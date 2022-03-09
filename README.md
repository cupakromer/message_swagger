# message_swagger

Demo Rails app for testing out Swaggio.io integration with Rails 7 and Ruby 3.


## Dependencies

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


## Additional Tools

- [Mermaid.js](https://mermaid-js.github.io/mermaid/#/) (Github now has
  built-in [support](https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/))
  for rendering mermaid code blocks)
- [ADR Tools](https://github.com/npryce/adr-tools)
