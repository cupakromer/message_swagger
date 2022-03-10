# frozen_string_literal: true

require 'radius/spec/model_factory'

Radius::Spec::ModelFactory.catalog do |c|
  c.factory(
    "User",
    handle: "any-handle",
    name: "Any Name",
  )
end
