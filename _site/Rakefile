require File.join(File.dirname(__FILE__), 'lib/pokrovsky.rb')
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'coveralls/rake/task'
require 'timecop'

Coveralls::RakeTask.new
RSpec::Core::RakeTask.new
Cucumber::Rake::Task.new

task :default => [:spec, :cucumber, 'coveralls:push']

task :generate do
  Timecop.freeze 1970, 01, 01
  @json = '{"id":"aaa","data":[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0],[0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0],[0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0],[0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]}'
  @h = Pokrovsky::Historiograph.new @json
  @h.user = 'pikesley'
  @h.repo = 'testicicle'
  puts @h.to_s
end

task :wipe_cassettes do
  `rm -fr fixtures/vcr/* spec/vcr/*`
end
