# XMLRPC::Rack

A rack app that serves a XMLRPC::BasicServer

## Installation

Add this line to your application's Gemfile:

    gem 'xmlrpc-rack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xmlrpc-rack

## Usage

XMLRPCServer = XMLRPC::BasicServer.new

XMLRPCServer.set_default_handler do |*args|
  ["echo", *args]
end

run XMLRPC::Rack.new XMLRPCServer


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
