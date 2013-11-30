require 'spec_helper'

module Pokrovsky
  describe Day do
    before :each do
      @d = Day.new '1974-06-15'
    end

    it 'should contain commits' do
      @d[0].class.should == Pokrovsky::Commit
    end

    it 'should contain 40 commits by default' do
      @d.length.should == 40
    end

    it 'should contain 10 commits when strength is 1' do
      @d.strength = 1
      @d.length.should == 10
    end
  end
end