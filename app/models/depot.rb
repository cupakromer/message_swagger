# frozen_string_literal: true

# ## Schema Information
#
# Table name: `depots`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `bigint`           | `not null, primary key`
# **`receiver_type`**  | `string`           | `not null`
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
# **`receiver_id`**    | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_depots_on_receiver` (_unique_):
#     * **`receiver_type`**
#     * **`receiver_id`**
#
class Depot < ApplicationRecord
  # Treat the polymorphic type column as the STI type as well
  #
  # This allows us to customize behavior via a subclass keeping our interfaces and associations
  # cleaner.
  self.inheritance_column = "receiver_type"
  self.store_full_sti_class = false

  # TODO: Add protections to prevent this receiver association from being swapped after creation
  belongs_to :receiver, polymorphic: true

  has_many :messages, dependent: :delete_all

  validates :receiver_id, on: :create, uniqueness: { scope: :receiver_type }

  validates :receiver_type, presence: true
end
