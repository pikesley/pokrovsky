require 'spec_helper'

module Pokrovsky
  describe Historiograph, :vcr do
    before :each do
      Timecop.freeze Time.local 2013, 12, 07
      @c         = Curl::Easy.new('http://dead-cockroach.herokuapp.com/1974')
      @c.headers = { 'Accept' => 'application/json' }
      @c.perform
    end
    let(:h) { Pokrovsky::Historiograph.new @c.body_str, 'pikesley', 'fakerepo' }

    it 'should contain a hash' do
      expect(h.get_current_calendar.class).to eq Hash
    end

    it 'should have days' do
      expect(h[0].class).to eq Pokrovsky::Day
    end

    it 'should have max_commits of 146' do
      expect(h.get_max_commits).to eq 146
    end

    it 'should dump a full git-abuse script' do
      expect(h.to_s).to match /#!\/bin\/bash/
      expect(h.to_s).to match /git init fakerepo/
      expect(h.to_s).to match /cd fakerepo/
      expect(h.to_s).to match /touch README.md/
#      expect(h.to_s).to match /GIT_AUTHOR_DATE=2013-08-23T12:00:00 GIT_COMMITTER_DATE=2013-08-23T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

#      expect(h.to_s).to match /GIT_AUTHOR_DATE=2013-09-20T12:00:00 GIT_COMMITTER_DATE=2013-09-20T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

      expect(h.to_s).to match /git remote add origin git@github.com:pikesley\/fakerepo.git/
      expect(h.to_s).to match /git pull/
      expect(h.to_s).to match /git push -u origin master/
    end

    describe 'one day' do
      let(:d) { h[30] }

      it 'should have 196 commits' do
        expect(d.length).to eq 196
      end
    end
  end
end
