# frozen_string_literal: true

json.data do
  json.array! @messages, partial: "api/v1/messages/message", as: :message
end
