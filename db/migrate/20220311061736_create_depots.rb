# frozen_string_literal: true

class CreateDepots < ActiveRecord::Migration[7.0]
  def change
    create_table :depots do |t|
      t.references :receiver, polymorphic: true, null: false, index: { unique: true }

      t.timestamps null: false
    end
  end
end
