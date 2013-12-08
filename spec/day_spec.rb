require 'spec_helper'

module Pokrovsky
  describe Day, :vcr do
    before :each do
      @d = Day.new '2013-06-15', 4, 79, 19
    end

    it 'should know that today is 2013-06-15' do
      @d.date.should == '2013-06-15'
    end

    it 'should have an intensity of 4' do
      @d.intensity.should == 4
    end

    it 'should know about max_commits being 79' do
      @d.max_commits.should == 79
    end

    it 'should think the current_score is 19' do
      @d.current_score.should == 19
    end

    it 'should be ready to unleash 85 commits' do
      @d.length.should == 85
    end

    before :each do
      @e = Day.new '1974-06-15', 3, 67, 21
    end

    it 'should be loaded with 45 commits' do
      @e.length.should == 45
    end

    it 'should have strings that look like git commits' do
      @e.to_s.should match /GIT_AUTHOR_DATE=1974-06-15T12:00:00 GIT_COMMITTER_DATE=1974-06-15T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/
    end

    it 'should have 45 of those' do
      @e.to_s.lines.length.should == 45
    end

    it 'should contain identical commits' do
      @e.to_s.lines.uniq.length.should == 1
    end
  end
end