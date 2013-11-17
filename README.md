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
