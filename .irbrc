require 'rubygems'
require 'wirble'

# start wirble(with color)
Wirble.init
Wirble.colorize

def log_to(stream = STDOUT)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
end
