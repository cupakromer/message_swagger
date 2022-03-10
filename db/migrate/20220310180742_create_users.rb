# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :handle, limit: 120, null: false
      t.string :name, limit: 400, null: false

      t.timestamps null: false
    end

    add_index :users, 'LOWER(handle)', unique: true
  end
end
