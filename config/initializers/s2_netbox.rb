require 's2_netbox'

S2Netbox.configure do |config|
  config.controller_url = if Net::Ping::HTTP.new('http://s2door').ping?
                            'http://s2door/'
                          else
                            'http://10.5.102.30/'
                          end
  config.username = ENV['S2_NETBOX_USERNAME']
  config.password = ENV['S2_NETBOX_PASSWORD']
end
