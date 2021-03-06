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
class Depot::User < Depot
  validates :receiver_type,
            inclusion: { in: %w[User], message: "must be User" }
end
