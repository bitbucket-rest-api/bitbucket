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

    it 'makes a GET request for all default reviewers belonging to the repo' do
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

    it 'makes a GET request for a default reviewer by username' do
      subject.get('mock_user', 'mock_repo', 'mock_reviewer')
    end
  end

  describe '#add' do
    before do
      expect(subject).to receive(:request).with(
        :put,
        '/2.0/repositories/mock_user/mock_repo/default-reviewers/mock_reviewer',
        {},
        {}
      )
    end

    it 'makes a PUT request to add the new reviewer to the default reviewers list' do
      subject.add('mock_user', 'mock_repo', 'mock_reviewer')
    end
  end

  describe '#remove' do
    before do
      expect(subject).to receive(:request).with(
        :delete,
        '/2.0/repositories/mock_user/mock_repo/default-reviewers/mock_reviewer',
        {},
        {}
      )
    end

    it 'makes a DELETE request to remove a reviewer from the list' do
      subject.remove('mock_user', 'mock_repo', 'mock_reviewer')
    end
  end
end
