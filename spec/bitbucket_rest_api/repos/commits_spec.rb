require 'spec_helper'

describe BitBucket::Repos::Commits do
  let(:commits) { BitBucket::Repos::Commits.new }

  describe '.list' do
    before do
      expect(commits).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_username/mock_repo/commits',
        {},
        {}
      ).and_return(["Commit1","Commit2","Commit3"])
    end

    context 'without a block' do
      it 'should send a GET request for the commits belonging to the given repo' do
        commits.list('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'should send a GET request for the commits belonging to the given repo' do
        commits.list('mock_username', 'mock_repo') {|commits| commits}
      end
    end
  end
end
