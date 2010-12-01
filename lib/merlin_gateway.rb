require 'rubygems'
require 'builder'
require 'typhoeus'
require 'pathname'

dir = Pathname(__FILE__).dirname.expand_path

require dir + 'merlin_gateway/client'
require dir + 'merlin_gateway/sms_message'

module MerlinGateway
end
