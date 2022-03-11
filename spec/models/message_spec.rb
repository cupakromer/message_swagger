# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validating a record" do
    fixtures :depots, :users

    subject(:valid_message) {
      build(
        Message,
        author: any_author,
        depot: any_depot,
        content: "Any valid message",
      )
    }

    let(:any_author) { users(:author) }

    let(:any_depot) { depots(:dm_friend) }

    before do
      expect(valid_message).to be_valid
    end

    it "requires an author" do
      expect(valid_message).to belong_to(:author).required
    end

    it "requires a depot" do
      expect(valid_message).to belong_to(:depot).required
    end

    it "requires some content" do
      expect(valid_message).to validate_presence_of(:content)
    end

    it "requires some content" do
      expect(valid_message).to validate_presence_of(:content)
    end

    it "requires content to be less than 4,000 characters" do
      expect(valid_message).to validate_length_of(:content).is_at_most(4_000)
    end

    it "supports unicode content" do
      long_unicode_content = "🍱" * 4_000

      expect {
        valid_message.content = long_unicode_content
      }.not_to change {
        valid_message.valid?
      }.from(true)

      expect(valid_message.save!).to eq(true)
    end
  end
end
