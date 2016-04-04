require 'spec_helper'

describe BitBucket::Repos::DefaultReviewers do
  subject { described_class.new }
  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/default-reviewers',
        {},
        {}
      )
    end

    it 'makes a GET request for all pull requests belonging to the repo' do
      subject.list('mock_user', 'mock_repo')
    end
  end

  describe '#get' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/default-reviewers/mock_reviewer',
        {},
        {}
      )
    end

    it 'makes a GET request for all pull requests belonging to the repo' do
      subject.get('mock_user', 'mock_repo', 'mock_reviewer')
    end
  end

  describe '#add_to_list' do
    before do
      expect(subject).to receive(:request).with(
        :put,
        '/2.0/repositories/mock_user/mock_repo/default-reviewers/mock_reviewer',
        {},
        {}
      )
    end

    it 'makes a GET request for all pull requests belonging to the repo' do
      subject.add_to_list('mock_user', 'mock_repo', 'mock_reviewer')
    end
  end
end
