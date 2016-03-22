require 'spec_helper'

describe BitBucket::Issues do
  let(:issue) { BitBucket::Issues.new }

  describe '.create' do
    before do
      expect(issue).to receive(:request).with(
        :post,
        '/1.0/repositories/mock_username/mock_repo/issues/',
        { 'title' => 'mock_issue' },
        {}
      )
    end

    it 'should send a POST request to create the issue' do
      issue.create('mock_username', 'mock_repo', { 'title' => 'mock_issue' })
    end
  end

  describe '.edit' do
    before do
      expect(issue).to receive(:request).with(
        :put,
        '/1.0/repositories/mock_username/mock_repo/issues/1/',
        { 'title' => 'new_title' },
        {}
      )
    end

    it 'should send a PUT request for the given issue' do
      issue.edit('mock_username', 'mock_repo', 1, { 'title' => 'new_title' })
    end
  end
end
