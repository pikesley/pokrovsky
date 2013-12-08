require 'spec_helper'

module Pokrovsky
  describe Historiograph, :vcr do
    before :each do
      Timecop.freeze Time.local 2013, 12, 07
      c         = Curl::Easy.new('http://uncleclive.herokuapp.com/1974/pokrovsky')
      c.headers = { 'Accept' => 'application/json' }
      c.perform

      @h = Pokrovsky::Historiograph.new c.body_str, 'pikesley', 'fakerepo'
    end

    it 'should contain a hash' do
      @h.get_current_calendar.class.should == Hash
    end

    it 'should have days' do
      @h[0].class.should == Pokrovsky::Day
    end

    it 'should have max_commits of 79' do
      @h.get_max_commits.should == 79
    end

    it 'should dump a full git-abuse script' do
      @h.to_s.should match /#!\/bin\/bash/
      @h.to_s.should match /git init fakerepo/
      @h.to_s.should match /cd fakerepo/
      @h.to_s.should match /touch README.md/
      @h.to_s.should match /GIT_AUTHOR_DATE=2013-08-23T12:00:00 GIT_COMMITTER_DATE=2013-08-23T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

      @h.to_s.should match /GIT_AUTHOR_DATE=2013-09-20T12:00:00 GIT_COMMITTER_DATE=2013-09-20T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

      @h.to_s.should match /git remote add origin git@github.com:pikesley\/fakerepo.git/
      @h.to_s.should match /git pull/
      @h.to_s.should match /git push -u origin master/
    end

    describe 'one day' do
      before :each do
        @d = @h[30]
      end

      it 'should have 140 commits' do
        @d.length.should == 140
      end
    end
  end
end