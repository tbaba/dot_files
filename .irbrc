require 'rubygems'
require 'utility_belt'
require 'wirble'
require 'webmock'
require 'pp'
require 'fakeweb'
require 'irb_rocket'
require 'active_record'

# start wirble(with color)
Wirble.init
Wirble.colorize

def log_to(stream = STDOUT)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
end
