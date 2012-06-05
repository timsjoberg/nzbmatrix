# Nzbmatrix

Gem to use the nzbmatrix api. For VIP members only

## Installation

Add this line to your application's Gemfile:

    gem 'nzbmatrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nzbmatrix

## Usage

    client = Nzbmatrix::Client.new('username', 'apikey')
    client.search "ubuntu"
    client.details 1095532
    client.download 1095532
    client.add_bookmark 1095532
    client.remove_bookmark 1095532

This next command just gives details about your account and it's api
usage

    client.account

Responses are completely unparsed at the moment.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
