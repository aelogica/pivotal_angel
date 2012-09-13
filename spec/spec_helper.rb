require 'pivotal_tracker'
require 'pivotal_angel'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before :all do
    directory = File.join(File.dirname(__FILE__),'fixtures')
    Dir.chdir(directory) do
      Dir["**/*.xml"].each do |file|
        url = "http://www.pivotaltracker.com/services/v3/#{file.sub(/\.xml$/,'')}"
        stub_request(:get, url).
          with(headers: {
                 'Accept' => 'application/xml',
                 'Content-type' => 'application/xml',
                 'User-Agent' => 'Ruby',
                 'X-Trackertoken' => '12345'
               }).
          to_return(status: 200, body: File.read(file), headers: {})
      end
    end
  end

  config.after :all do
    WebMock.reset!
  end
end
