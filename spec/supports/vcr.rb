require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.default_cassette_options = { :record => :once }
  c.hook_into :webmock
end
