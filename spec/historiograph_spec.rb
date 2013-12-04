module Pokrovsky
  describe Historiograph do
    before :each do
      Timecop.freeze Time.local 1970, 01, 01
      @json = '{
        "id": "arbitrary",
        "data": [
          [1, 0],
          [0, 0],
          [1, 0],
          [0, 0],
          [0, 0],
          [0, 0],
          [0, 0]
          ]
        }'
      @h    = Historiograph.new @json
    end

    it 'should contain days' do
      @h[0].class.should == Pokrovsky::Day
    end

    it 'should start on Sunday 27 weeks ago' do
      @h[0].date.should == '1969-06-29'
    end

    it 'should have length 2' do
      @h.length.should == 2
    end

    describe 'more realistic situation' do
      before :each do
        Timecop.freeze Time.local 1974, 06, 15
        @json   = '{
          "id": "1982",
          "data": [
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0],
            [0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0],
            [0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,0],
            [0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,0,0,1,0,0,0,0,1,0,0,0,1,1,1,1,0,0],
            [0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,1,1,0]
          ]
        }'
        @h      = Historiograph.new @json
        @h.user = 'fake-github-user'
        @h.repo = 'fake-repo-name'
      end

      it 'should have length 66' do
        @h.length.should == 66
      end

      it 'should have its first commit on the 13th Monday past 1 year ago' do
        @h[0].date.should == '1973-09-11'
      end

      it 'should have its last commit on the 41st Saturday past 1 year ago' do
        @h[65].date.should == '1974-03-30'
      end

      it 'should have the correct repo name' do
        @h.repo.should == 'fake-repo-name'
      end

      it 'should dump a full git-abuse script' do
        @h.to_s.should match /#!\/bin\/bash/
        @h.to_s.should match /git init fake-repo-name/
        @h.to_s.should match /cd fake-repo-name/
        @h.to_s.should match /touch README.md/
        @h.to_s.should match /git add README.md/
        @h.to_s.should match /GIT_AUTHOR_DATE=1973-09-11T12:00:00 GIT_COMMITTER_DATE=1973-09-11T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

        @h.to_s.should match /GIT_AUTHOR_DATE=1974-03-30T12:00:00 GIT_COMMITTER_DATE=1974-03-30T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

        @h.to_s.should match /git remote add origin git@github.com:fake-github-user\/fake-repo-name.git/
        @h.to_s.should match /git pull/
        @h.to_s.should match /git push -u origin master/
      end
    end

    describe 'situation with 4s, not 1s' do
      before :each do
        Timecop.freeze Time.local 1974, 06, 15
        @json   = '{
          "id": "1982",
          "data": [
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,4,4,0,0,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4,0,0],
            [0,0,4,0,4,0,0,0,0,4,0,0,0,0,4,0,0,4,0,0,0,0,4,0,0,4,0,0,0,0,4,0],
            [0,0,0,0,4,0,0,0,0,4,0,0,0,0,4,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,4,0],
            [0,0,0,0,4,0,0,0,0,0,4,4,4,4,4,0,0,4,0,0,0,0,4,0,0,0,4,4,4,4,0,0],
            [0,0,0,0,4,0,0,0,0,0,0,0,0,0,4,0,0,4,0,0,0,0,4,0,0,4,0,0,0,0,0,0],
            [0,0,4,4,4,4,4,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4,0,0,0,4,4,4,4,4,4,0]
          ]
        }'
        @h      = Historiograph.new @json
        @h.user = 'fake-github-user'
        @h.repo = 'fake-repo-name'
      end

      it 'should have length 66' do
        @h.length.should == 66
      end

      it 'should have its first commit on the 13th Monday past 1 year ago' do
        @h[0].date.should == '1973-09-11'
      end

      it 'should have its last commit on the 41st Saturday past 1 year ago' do
        @h[65].date.should == '1974-03-30'
      end

      it 'should have the correct repo name' do
        @h.repo.should == 'fake-repo-name'
      end

      it 'should dump a full git-abuse script' do
        @h.to_s.should match /#!\/bin\/bash/
        @h.to_s.should match /git init fake-repo-name/
        @h.to_s.should match /cd fake-repo-name/
        @h.to_s.should match /touch README.md/
        @h.to_s.should match /git add README.md/
        @h.to_s.should match /GIT_AUTHOR_DATE=1973-09-11T12:00:00 GIT_COMMITTER_DATE=1973-09-11T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

        @h.to_s.should match /GIT_AUTHOR_DATE=1974-03-30T12:00:00 GIT_COMMITTER_DATE=1974-03-30T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/

        @h.to_s.should match /git remote add origin git@github.com:fake-github-user\/fake-repo-name.git/
        @h.to_s.should match /git pull/
        @h.to_s.should match /git push -u origin master/
      end
    end

    describe 'get max commits' do
      before :each do
        Timecop.freeze Time.local 2013, 12, 03
        @json   = '{
          "id": "1982",
          "data": [
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,4,4,0,0,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4,0,0],
            [0,0,4,0,4,0,0,0,0,4,0,0,0,0,4,0,0,4,0,0,0,0,4,0,0,4,0,0,0,0,4,0],
            [0,0,0,0,4,0,0,0,0,4,0,0,0,0,4,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,4,0],
            [0,0,0,0,4,0,0,0,0,0,4,4,4,4,4,0,0,4,0,0,0,0,4,0,0,0,4,4,4,4,0,0],
            [0,0,0,0,4,0,0,0,0,0,0,0,0,0,4,0,0,4,0,0,0,0,4,0,0,4,0,0,0,0,0,0],
            [0,0,4,4,4,4,4,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4,0,0,0,4,4,4,4,4,4,0]
          ]
        }'
        @h      = Historiograph.new @json
        @h.user = 'pikesley'
      end

      it 'should have 112 commits' do #, :vcr do
        @h.max_commits.should == 112
      end

      it 'should have a multiplier of 28' do
        @h.multiplier.should == 28
      end
    end
  end
end