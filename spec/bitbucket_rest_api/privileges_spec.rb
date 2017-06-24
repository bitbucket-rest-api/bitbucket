require 'spec_helper'

describe BitBucket::Privileges do
  let(:repo) { BitBucket::Privileges.new }

  describe '.repo_list' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/privileges/mock_username/mock_repo',
        {},
        {}
      )
    end

    it 'should send a GET request for the given repo' do
      repo.repo_list('mock_username', 'mock_repo')
    end
  end
end
