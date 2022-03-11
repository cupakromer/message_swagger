# frozen_string_literal: true

# ## Schema Information
#
# Table name: `messages`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`content`**     | `string(4000)`     | `not null`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`author_id`**   | `bigint`           | `not null`
# **`depot_id`**    | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_messages_on_author_id`:
#     * **`author_id`**
# * `index_messages_on_depot_id`:
#     * **`depot_id`**
#
# ### Foreign Keys
#
# * `fk_rails_995937c106` (_ON DELETE => cascade_):
#     * **`author_id => users.id`**
# * `fk_rails_e0b15f1a9c`:
#     * **`depot_id => depots.id`**
#
class Message < ApplicationRecord
  # TODO: Add protections to prevent the author association from being swapped after creation
  belongs_to :author, class_name: "User", inverse_of: :authored_messages

  # TODO: Add protections to prevent the depot association from being swapped after creation
  belongs_to :depot

  validates :content,
            presence: true,
            length: { maximum: 4_000 }
end
