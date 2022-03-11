# frozen_string_literal: true

# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`handle`**      | `string(120)`      | `not null`
# **`name`**        | `string(400)`      | `not null`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_LOWER_handle` (_unique_):
#     * **`lower((handle)::text)`**
#
class User < ApplicationRecord
  has_one :direct_depot, class_name: "Depot::User", as: :receiver, dependent: :delete

  # TODO: Is there a better domain term for this? (compositions?)
  has_many :authored_messages,
           class_name: "Message",
           foreign_key: :author_id,
           inverse_of: :author,
           dependent: :delete_all

  validates :handle,
            presence: true,
            length: { maximum: 120 },
            uniqueness: {
              if: :handle_changed?,
              case_sensitive: false,
            }

  # Names are highly subjective and may take different forms for different purposes. This is simply
  # a display name for us so we want to be as flexible to the user as possible. But we want to have
  # some cap on the length to be respectful for UI space.
  validates :name,
            presence: true,
            length: { maximum: 400 }

  # TODO: Promote this to a customized association/scope to support eager loading
  def messages
    query = authored_messages
    query = query.or(direct_depot.messages) if direct_depot

    query
  end
end
