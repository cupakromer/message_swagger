# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Message Swagger API V1',
        description: 'This is a demo server for a messaging API',
        license: {
          name: "Apache 2.0",
          url: "https://www.apache.org/licenses/LICENSE-2.0.html",
        },
        version: '1.0.0',
      },
      paths: {},
      servers: [
        {
          url: '{scheme}://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000',
            },
            scheme: {
              enum: %w[https http],
              default: 'http',
            },
          },
        },
      ],
      security: [
        { BearerAuth: [] },
      ],
      components: {
        # Turn off Rubocop to stop warning on the example ID values
        # rubocop:disable Style/NumericLiterals
        schemas: {
          Message: {
            type: :object,
            properties: {
              id: {
                type: :integer,
                format: :int64,
                description: "Unique resource identifier",
                example: 1532513,
              },
              author_id: {
                type: :integer,
                format: :int64,
                description: "Unique resource identifier for the `User` whom authored the message",
                example: 1034934475,
              },
              depot: {
                type: :object,
                description: "Unique compound key identifing the receiver of the message",
                properties: {
                  receiver_id: {
                    type: :integer,
                    format: :int64,
                    description: "Unique resource identifier scoped by `resource_type`",
                    example: 367963234,
                  },
                  receiver_type: {
                    type: :string,
                    enum: %w[User],
                    description: "Resource type name of the receiver",
                    example: "User",
                  },
                },
                required: %i[receiver_id receiver_type],
              },
              content: {
                type: :string,
                description: "Raw text of the message",
                example: "Hello Friend",
              },
              created_at: {
                type: :string,
                format: 'date-time',
                description: "ISO-8601 UTC timestamp of when the message was created",
                example: "2022-03-11T22:35:14.837Z",
              },
              updated_at: {
                type: :string,
                format: 'date-time',
                description: "ISO-8601 UTC timestamp of when the message record was last modified",
                example: "2022-03-11T22:35:14.837Z",
              },
              url: {
                type: :string,
                format: :url,
                description: "URL to fetch this resource",
              },
            },
            required: %i[id author_id depot content],
          },
        },
        # rubocop:enable Style/NumericLiterals
        securitySchemes: {
          BearerAuth: {
            type: :http,
            description: "Placeholder auth for demo purposes only (TODO: Replace with secure auth)",
            scheme: :bearer,
            bearerFormat: "AUTH-PLACEHOLDER-USER_ID",
          },
        },
      },
    },
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
