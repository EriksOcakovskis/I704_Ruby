# FluffyPaws

A website using Sinatra for Estonian IT College I704 class.

A live demo can be found [Here](https://tranquil-caverns-83807.herokuapp.com)

## Installation

Gem is not available on RubyGems.org.

Add this line to your application's Gemfile:

```ruby
gem 'fluffy_paws', git: 'git@github.com:EriksOcakovskis/I704_Ruby.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone git@github.com:EriksOcakovskis/I704_Ruby.git
    $ cd I704_Ruby && gem build fluffy_paws.gemspec
    $ gem install fluffy_paws-0.2.0.gem

Then configure environment variables by executing (adjust parameters according to your environment):

    echo export DATABASE_URL=\'postgres://localhost/my_db?user=some_user\'>> ~/.bash_profile
    echo export SENDGRID_API_KEY=\'some_mail_api_key\'>> ~/.bash_profile
    echo export SERVER_URL=\'http://localhost:8000\'>> ~/.bash_profile

## Usage

Before running app execute:

    $ rake db:migrate

Run on local machine by executing:

    $ rackup

Run on a server by executing something like this:

    $ bundle exec rackup config.ru -p $PORT

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Eriks Ocakovskis/fluffy_paws. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

