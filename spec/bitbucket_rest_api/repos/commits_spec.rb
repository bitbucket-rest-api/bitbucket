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
      )
    end

    it 'should send a GET request for the commits belonging to the given repo' do
      commits.list('mock_username', 'mock_repo')
    end
  end
end
