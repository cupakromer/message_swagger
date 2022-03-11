# frozen_string_literal: true

class API::V1::ResourceController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # Default number of records returned for collection actions
  class_attribute :limit_default, default: 100

  # Maximum number of records returned for collection actions
  class_attribute :limit_max, default: 100

  before_action :authenticate_with_bearer

  before_action :munge_collection_params, only: %i[index] # rubocop:disable Rails/LexicallyScopedActionFilter

protected

  # Perform HTTP authentication via the Authorization header
  #
  # The format for the header must be the following:
  #
  #   Authorization: Bearer AUTH_TOKEN
  #
  # @see https://github.com/rails/rails/blob/v7.0.2.3/actionpack/lib/action_controller/metal/http_authentication.rb#L415-L417
  # @see https://github.com/rails/rails/blob/v7.0.2.3/actionpack/lib/action_controller/metal/http_authentication.rb#L423-L425
  # @see https://github.com/rails/rails/blob/v7.0.2.3/actionpack/lib/action_controller/metal/http_authentication.rb#L514-L518
  def authenticate_with_bearer
    authenticate_or_request_with_http_token("API v1") do |token, _options|
      # TODO: Replace this with an actual secure authentication strategy
      /\AAUTH-PLACEHOLDER-(?<user_id>\d+)\z/ =~ token

      AppContext.current_user = User.find_by(id: user_id) if user_id
    end
  end

  # Munge all collection params based on the controller's configuration
  def munge_collection_params
    munge_param :limit, default: limit_default, max: limit_max
  end

  # Munge a query param to keep it within expected limits
  #
  # If the provided value is outside the bounds the max will be used. We may change the max for
  # performance reasons and we do not want to break existing clients by raising an error if the
  # value is too large.
  def munge_param(key, default:, max: nil)
    params[key] ||= default
    value = params[key].to_i
    value = default if value < 1
    params[key] = (max ? [value, max].min : value)
  end
end
