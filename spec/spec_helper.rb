# frozen_string_literal: true

require 'dotenv'
Dotenv.load '.env'
Dotenv.overload '.env.test'

require 'radius/spec'

# This file will always be loaded when specs run. Keep it as light weight as
# possible to avoid slowing down isolated TDD loops.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # This is a Rails app with too many noisy gems
  config.warnings = false
end
