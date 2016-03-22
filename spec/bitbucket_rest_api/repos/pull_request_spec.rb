require 'spec_helper'

describe BitBucket::Repos::PullRequest do
  let(:pull_request) { described_class.new }
  describe '.list' do
    before do
      expect(pull_request).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_username/mock_repo/pullrequests',
        {},
        {}
      )
    end

    it 'should make a GET request for the list of pull requests' do
      pull_request.list('mock_username', 'mock_repo')
    end
  end

  describe '.participants' do
    before do
      expect(pull_request).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/pullrequests/mock_pull_request_id/participants',
        {},
        {}
      )
    end

    it 'should make a GET request for the list of participants' do
      pull_request.participants('mock_username', 'mock_repo', 'mock_pull_request_id')
    end
  end
end
