module MerlinGateway

	class SmsMessage
		attr_accessor :target_number, :message, :price
		attr_reader   :client

		def initialize(target_number, message, options={})
			@target_number = target_number
			@message = message
			@client = options[:client]
			@price = options[:price] || 0
		end
		
		def deliver!
			xml_data = self.to_xml
			response = Typhoeus::Request.post(
				'http://www.mobile-entry.com/gate/service', 
				#:method   => :post,
				:headers  => {'Content-type' => 'text/xml'},
				:username => client.username,
				:password => client.password,
				:body => xml_data
			)
		end
		
		def to_xml
			builder = Builder::XmlMarkup.new#(:indent=>2)
			builder.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
			xml_data = builder.gate do |gate|
				gate.country client.country
				gate.accessNumber client.access_number
				gate.senderNumber client.sender_number
				gate.targetNumber target_number
				gate.price price
				gate.sms do |sms|
					sms.content do |content|
						content.cdata! message
					end
				end
			end
		end
	end
	
end