require 'vcr'
#require 'webmock/cucumber'

VCR.configure do |c|
  c.default_cassette_options = { :record => :once }
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
#  c.hook_into :webmock
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
