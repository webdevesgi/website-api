# LaboWebESGI API

## Requirements

- Ruby 2
- Rails 4 `gem install rails`
- RSpec `gem install rspec`
- Bundler `gem install bundler`

## Development

    bundle install
    rake db:migrate
    rails s -p 5000

## Tests

    rake db:migrate db:test:prepare
    rspec spec

Make sure you have created the file `config/application.yml` with the following content:

    # Add application configuration variables here, as shown below.

    AUTHORIZED_APPS:
      - 127.0.0.1
      - localhost

It will enable your client application in development mode to access to the API.
