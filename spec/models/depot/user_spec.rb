# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Depot::User, type: :model do
  describe "validating a record" do
    subject(:valid_depot) {
      Depot::User.new(receiver: any_user)
    }

    let(:any_user) { build(User) }

    before do
      expect(valid_depot).to be_valid
    end

    it "TODO: Include the Depot validation tests here to as they are inherited"

    it "requires an approved receiver type" do
      # Shoulda matchers doesn't work for STI in this manner due to STI requiring the value to be a
      # known constant
      expect {
        valid_depot.receiver_type = "ApplicationRecord"
      }.to change {
        valid_depot.valid?
      }.from(true).to(false).and change {
        valid_depot.errors[:receiver_type]
      }.to include("must be User")
    end
  end
end
