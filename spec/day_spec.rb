require 'spec_helper'

module Pokrovsky
  describe Day do
    before :each do
      @d = Day.new '1974-06-15'
    end

    it 'should contain commits' do
      @d[0].class.should == Pokrovsky::Commit
    end

    it 'should contain 18 commits' do
      @d.length.should == 18
    end

    it 'should contain 72 commits when strength is 4' do
      @d.strength = 4
      @d.length.should == 72
    end
  end
end