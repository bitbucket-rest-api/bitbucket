require 'spec_helper'

describe BitBucket::Issues::Comments do
  let(:comments) { described_class.new }

  describe '.list' do
    before do
      expect(comments).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues/mock_issue_id/comments/',
        {},
        {}
      ).and_return(['comment1', 'comment2', 'comment3'])
    end

    context 'without a block' do
      it 'should make a GET request for the given issue' do
        comments.list('mock_username', 'mock_repo', 'mock_issue_id')
      end
    end

    context 'with a block' do
      it 'should make a GET request for the given issue' do
        comments.list('mock_username', 'mock_repo', 'mock_issue_id') { |comment| comment }
      end
    end
  end

  describe '.get' do
    before do
      expect(comments).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues/comments/mock_comment_id',
        {},
        {}
      )
    end

    it 'should make a GET request for the given comment' do
      comments.get('mock_username', 'mock_repo', 'mock_comment_id')
    end
  end

  describe '.create' do
    before do
      expect(comments).to receive(:request).with(
        :post,
        '/1.0/repositories/mock_username/mock_repo/issues/mock_issue_id/comments/',
        {'content' => 'mock_comment'},
        {}
      )
    end

    it 'should send a POST request for the given issue' do
      comments.create('mock_username', 'mock_repo', 'mock_issue_id', 'content' => 'mock_comment')
    end
  end

  describe '.edit' do
    before do
      expect(comments).to receive(:request).with(
        :put,
        '/1.0/repositories/mock_username/mock_repo/issues/comments/mock_comment_id',
        {'content' => 'new_mock_comment'},
        {}
      )
    end

    it 'should send a PUT request for the given comment' do
      comments.edit('mock_username', 'mock_repo', 'mock_comment_id', 'content' => 'new_mock_comment')
    end
  end

  describe '.delete' do
    before do
      expect(comments).to receive(:request).with(
        :delete,
        '/1.0/repositories/mock_username/mock_repo/issues/comments/mock_comment_id',
        {},
        {}
      )
    end

    it 'should make a DELETE request for the given comment' do
      comments.delete('mock_username', 'mock_repo', 'mock_comment_id')
    end
  end
end

