# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :author,
                   null: false,
                   foreign_key: { to_table: :users, on_delete: :cascade },
                   index: true

      t.references :depot, null: false, foreign_key: true, index: true

      t.string :content, limit: 4000, null: false

      t.timestamps null: false
    end
  end
end
