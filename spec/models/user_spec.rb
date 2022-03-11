# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validating record" do
    subject(:valid_user) {
      build(User)
    }

    before do
      expect(valid_user).to be_valid
    end

    it "requires a handle" do
      expect(valid_user).to validate_presence_of(:handle)
    end

    it "requires a handle to be less than 120 characters" do
      expect(valid_user).to validate_length_of(:handle).is_at_most(120)
    end

    it "requires a unique handle" do
      expect(valid_user).to validate_uniqueness_of(:handle).case_insensitive

      # TODO: Add spec helpers for counting SQL queries and verify we don't run the extra queries
      # TODO: unless the value has changed.
    end

    it "supports unicode handles" do
      long_unicode_name = "🍱" * 120

      expect {
        valid_user.handle = long_unicode_name
      }.not_to change {
        valid_user.valid?
      }.from(true)

      expect(valid_user.save!).to eq(true)
    end

    it "requires a name" do
      expect(valid_user).to validate_presence_of(:name)
    end

    it "requires a name to be less than 400 characters" do
      expect(valid_user).to validate_length_of(:name).is_at_most(400)
    end

    it "supports unicode names" do
      long_unicode_name = "🍱" * 400

      expect {
        valid_user.name = long_unicode_name
      }.not_to change {
        valid_user.valid?
      }.from(true)

      expect(valid_user.save!).to eq(true)
    end
  end

  describe "direct depot association", pending: "TODO: Skipping due to time constraints" do
    it "has only one"

    it "supports no association set"

    it "deletes the association when the user is deleted"

    # Inverse associations are important for helping to reduce memory overhead and unexpected N+1
    # queries
    it "has a correct inverse association"
  end

  describe "authored messages association", pending: "TODO: Skipping due to time constraints" do
    it "may have many"

    it "only includes messages authored by the user"

    it "deletes all the messages when the user is deleted"

    # Inverse associations are important for helping to reduce memory overhead and unexpected N+1
    # queries
    it "has a correct inverse association"
  end
end
