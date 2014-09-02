require 'spec_helper'

module Pokrovsky
  describe Commit do
    it 'should print correctly' do
      @c = Pokrovsky::Commit.new '1974-06-15'
      @c.to_s.should == 'GIT_AUTHOR_DATE=1974-06-15T12:00:00 GIT_COMMITTER_DATE=1974-06-15T12:00:00 git commit --allow-empty -m "Rewriting History!" > /dev/null'
    end
  end
end