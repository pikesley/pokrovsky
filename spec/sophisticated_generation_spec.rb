require 'spec_helper'

module Pokrovsky
  describe Historiograph, :vcr do
    before :each do
      Timecop.freeze Time.local 2013, 12, 05
      c         = Curl::Easy.new('http://uncleclive.herokuapp.com/1974')
      c.headers = { 'Accept' => 'application/json' }
      c.perform

      @h      = Pokrovsky::Historiograph.new c.body_str
      @h.user = 'pikesley'
    end

    it 'should have days' do
      @h[0].class.should == Pokrovsky::Day
    end

    it 'should have max_commits of 139' do
      @h.max_commits.should == 139
    end
  end
end