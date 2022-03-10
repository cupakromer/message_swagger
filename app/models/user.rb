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
end
