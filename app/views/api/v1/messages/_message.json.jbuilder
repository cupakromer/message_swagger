# frozen_string_literal: true

json.extract! message, :id, :author_id, :content, :created_at, :updated_at
json.depot message.depot.slice(:receiver_id, :receiver_type)
json.url api_v1_message_url(message)
