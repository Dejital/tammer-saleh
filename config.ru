require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'nesta/app'

$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")

Dir[File.join(File.dirname(__FILE__), 'lib/extensions/**/*.rb')].each {|extension| require extension }

require 'active_support/core_ext/object'

Nesta::App.root = ::File.expand_path('.', ::File.dirname(__FILE__))
run Nesta::App
