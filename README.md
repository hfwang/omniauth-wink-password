[![Gem Version](https://badge.fury.io/rb/omniauth-lifx.svg)](https://badge.fury.io/rb/omniauth-lifx)

# omniauth-wink-password

An OmniAuth strategy for Wink OAuth2 integration (using their android app client credentials!)

*Note*: This strategy is pretty much 100% evil, it requests their email/password and logs in as them directly!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-wink-password'
```

And then execute:

    $ bundle

## Usage

You could add the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wink_password
end
```

The access_token, refresh_token, email and password used to log in are returned in the credentials hash.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hfwang/omniauth-lifx. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
