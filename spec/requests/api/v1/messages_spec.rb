# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe "API v1: Messages Resource", type: :request do
  fixtures :depots, :users

  let(:current_user) {
    build(User, handle: "current-user", name: "Any Current User", &:build_direct_depot)
  }

  path "/api/v1/messages" do
    get "Get all your messages" do
      tags "Messages"

      consumes "application/json"
      produces "application/json"

      parameter name: :limit,
                required: false,
                description: "Limits number of record returned" \
                             " (default: #{API::V1::MessagesController.limit_default}," \
                             " max: #{API::V1::MessagesController.limit_max})",
                in: :query,
                type: :integer,
                example: 5

      parameter name: :since,
                required: false,
                description: "Limits records to those having created since this many days ago" \
                             " (default: 30, max: 30)",
                in: :query,
                type: :integer,
                example: 30

      response "200", "messages found" do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     "$ref" => '#/components/schemas/Message',
                   },
                 },
               }

        let(:Authorization) { "Bearer AUTH-PLACEHOLDER-#{current_user.id}" }

        let(:limit) { 2 }

        let(:greeting_to_friend) {
          current_user.authored_messages.create!(
            depot: users(:friend).direct_depot,
            content: "Hello Friend",
          )
        }

        let(:friend_reply) {
          users(:friend).authored_messages.create!(
            depot: current_user.direct_depot,
            content: "Good day to you too",
          )
        }

        before do
          current_user.save!

          greeting_to_friend.save!
          friend_reply.save!

          # Create this after the friend conversation so the ID is newer, but make the timestamp
          # older so it is filtered out
          current_user.authored_messages.create!(
            depot: current_user.direct_depot,
            content: "Friendly note to self",
            created_at: 31.days.ago,
          )
        end

        run_test! do |response|
          message_ids = response.parsed_body.fetch("data").map { |msg| msg.fetch("id") }

          # We sort newests to olders by ID
          expect(message_ids).to eq([friend_reply.id, greeting_to_friend.id])
        end
      end
    end
  end

  path "/api/v1/messages/{id}" do
    get "Get a single message" do
      tags "Messages"

      consumes "application/json"
      produces "application/json"

      parameter name: :id, in: :path, type: :integer

      response "200", "message found" do
        schema type: :object,
               properties: {
                 data: {
                   "$ref" => '#/components/schemas/Message',
                 },
               }

        let(:Authorization) { "Bearer AUTH-PLACEHOLDER-#{current_user.id}" }

        let(:message_to_self) {
          current_user.authored_messages.create!(
            depot: current_user.direct_depot,
            content: "Friendly note to self",
          )
        }

        let(:id) { message_to_self.id }

        before do
          current_user.save!

          message_to_self.save!
        end

        run_test! do |response|
          expect(response.parsed_body.dig("data", "content")).to eq("Friendly note to self")
        end
      end

      response "404", "message not found" do
        let(:Authorization) { "Bearer AUTH-PLACEHOLDER-#{current_user.id}" }

        let(:another_user_message) {
          another_user = users(:friend)
          another_user.authored_messages.create!(
            depot: another_user.direct_depot,
            content: "Another User's Note",
          )
        }

        let(:id) { another_user_message.id }

        before do
          current_user.save!

          another_user_message.save!
        end

        run_test!
      end
    end
  end
end
