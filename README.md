# message_swagger

Demo Rails app for testing out Swaggio.io integration with Rails 7 and Ruby 3.


## Dependencies

This assumes you already have Ruby 3.1.1 installed or know how to install it.

- Ruby 3.1.1
- Rails 7
- PostgreSQL 13+

If you do not have PostgreSQL installed, you can install
[Postgres.app](https://postgresapp.com/) on a Mac. If you are running either
Windows or Linux, I suggest referencing the helpful setup information provided
by [Heroku](https://devcenter.heroku.com/articles/heroku-postgresql#local-setup).


## Getting Started

Clone the repo to your local system.

If this is the first time running the app execute, execute `bin/setup` to
install all of the dependencies and prepare the local database. If you have
pulled down recent updates, continue to use `bin/setup` to keep deps up-to-date
and run any outstanding migrations.


## Testing

This uses RSpec to test the code. To run the test suite execute `bin/rspec`.


## Documentation

For information about design decisions check out the [ADRs][doc/adrs](architecture decision
records). Check out our [ADR about including ADRs](doc/adr/20220310151922-record-architecture-decisions.md).

### API v1

This project uses Swagger.io (via the `rswag` gem) to self host the API docs.

The first version of the API docs are generated from specs which specify an
[OpenAPI](https://www.openapis.org) spec from requests specs via the `rswag` gem. The compiled
spec file can be found at [swagger/v1/swagger.yml](swagger/v1/swagger.yml).

There are three suggested ways to view the generated documentation:

1. VSCode Extension: [OpenAPI (Swagger) Editor](https://marketplace.visualstudio.com/items?itemName=42Crunch.vscode-openapi)

   After installing the extension, open the spec file:
   [swagger/v1/swagger.yml](swagger/v1/swagger.yml). Click on the preview pane to see the generated
   docs.
2. Via the local Rails dev server

   In your editor of choice or the terminal start the Rails server:

   ```console
   $ bin/rails s
   => Booting Puma
   => Rails 7.0.2.3 application starting in development
   => Run `bin/rails server --help` for more startup options
   Puma starting in single mode...
   * Puma version: 5.6.2 (ruby 3.1.1-p18) ("Birdie's Version")
   *  Min threads: 5
   *  Max threads: 5
   *  Environment: development
   *          PID: 87999
   * Listening on http://127.0.0.1:3000
   * Listening on http://[::1]:3000
   Use Ctrl-C to stop
   ```

   Open one of the listed URLs (or use `http://localhost:3000`). The index will redirect you to the
   docs.
3. Via the Swagger.io [Live Editor](https://editor.swagger.io)

   After navigating to the [Live Editor](https://editor.swagger.io) copy the contents of
   [swagger/v1/swagger.yml](swagger/v1/swagger.yml) into the left side text section.

   Or from the live editor's menu bar, choose **File** > **Import URL** and paste the raw link from
   Github.

## Additional Tools

- [Mermaid.js](https://mermaid-js.github.io/mermaid/#/) (Github now has
  built-in [support](https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/))
  for rendering mermaid code blocks)
- [ADR Tools](https://github.com/npryce/adr-tools)
