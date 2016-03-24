require 'spec_helper'
require 'ostruct'

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

  describe '.get' do
    before do
      expect(issue).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues/1',
        {},
        {}
      )
    end

    it 'should send a GET request for the given issue' do
      issue.get('mock_username', 'mock_repo', 1, {})
    end
  end

  describe '.delete' do
    before do
      expect(issue).to receive(:request).with(
        :delete,
        '/1.0/repositories/mock_username/mock_repo/issues/1',
        {},
        {}
      )
    end

    it 'should send a DELETE request for the given issue' do
      issue.delete('mock_username', 'mock_repo', 1)
    end
  end

  describe '.list_repo' do
    before do
      expect(issue).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues',
        {},
        {}
      ).and_return(OpenStruct.new(:issues => [])).twice
    end

    it 'should send a GET request for the issues for that repo' do
      issue.list_repo('mock_username', 'mock_repo')
      issue.list_repo('mock_username', 'mock_repo') { |issue| issue }
    end
  end

  describe "getter methods" do
    it "returns an object of the correct class" do
      expect(issue.comments).to be_a BitBucket::Issues::Comments
      expect(issue.components).to be_a BitBucket::Issues::Components
      expect(issue.milestones).to be_a BitBucket::Issues::Milestones
    end
  end
end
