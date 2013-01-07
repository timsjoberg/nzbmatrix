# Nzbmatrix

Gem to interact with http://nzb-matrix.eu. You need to sign up for an
account and visit your profile page to get your user id (the 'i'
param) and API key (the 'r' param).

## Installation

Add this line to your application's Gemfile:

    gem 'nzbmatrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nzbmatrix

## Usage

    client = Nzbmatrix::Client.new(user_id, key)
    client.search "ubuntu"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
