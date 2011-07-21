require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'nesta/app'

$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")

# require 'active_support/core_ext/object'
require 'active_support/all'
require 'padrino-helpers'

Dir[File.join(File.dirname(__FILE__), 'lib/**/*.rb')].each {|lib| require lib }

Nesta::App.root = ::File.expand_path('.', ::File.dirname(__FILE__))
run Nesta::App
