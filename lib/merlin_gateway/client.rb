module MerlinGateway

	class Client
		attr_accessor :username, :password, :access_number, :sender_number, :country

		def initialize(options)
			@username      = options[:username]
			@password      = options[:password]
			@access_number = options[:access_number] || '2210'
			@sender_number = options[:sender_number] || @access_number
			@country       = options[:country]       || 'NO'
		end
		
		def new_message(target_number, message, options={})
			::MerlinGateway::SmsMessage.new(target_number, message, options.merge({:client => self}))
		end
	end

end