# frozen_string_literal: true

require 'radius/spec/model_factory'

Radius::Spec::ModelFactory.catalog do |c|
  c.factory(
    "Message",
    author: :required,
    depot: :required,
    content: "Any message text",
  )

  c.factory(
    "User",
    handle: -> { "any-handle#{rand(100_000)}" },
    name: "Any Name",
  )
end
