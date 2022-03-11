# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Depot, type: :model do
  describe "validating a record" do
    subject(:valid_depot) {
      Depot.new(receiver: any_receiver)
    }

    let(:any_receiver) { build(User) }

    before do
      expect(valid_depot).to be_valid
    end

    it "requires a receiver" do
      expect(valid_depot).to belong_to(:receiver).required
    end

    it "validates the receiver is unique on creation" do
      expect(valid_depot).to(
        validate_uniqueness_of(:receiver_id)
        .scoped_to(:receiver_type)
        .on(:create)
      )
    end

    it "requires a receiver type" do
      expect(valid_depot).to validate_presence_of(:receiver_type)
    end
  end
end
