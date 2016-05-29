require 'spec_helper'

describe BitBucket::Repos do
  let(:repo) { BitBucket::Repos.new }

  # class_eval is setting global variables in api.rb, this is creating
  # failed expectations when these variables are not reset to nil before
  # the next test is run. Therefore we must clear them manually as
  # for the user attribute below...
  after do
    repo.clear_user
  end

  describe '.create' do
    before do
      expect(repo).to receive(:request).with(
        :post,
        '/1.0/repositories/',
        BitBucket::Repos::DEFAULT_REPO_OPTIONS.merge({ 'owner' => 'mock_owner', 'name' => 'mock_repo' }),
        {}
      )
    end

    it 'should send a POST request to create the repo' do
      repo.create({ 'owner' => 'mock_owner', 'name' => 'mock_repo' })
    end
  end

  describe '.delete' do
    before do
      expect(repo).to receive(:request).with(
        :delete,
        '/1.0/repositories/mock_username/mock_repo',
        {},
        {}
      )
    end

    it 'should send a DELETE request for the given repo' do
      repo.delete('mock_username', 'mock_repo')
    end
  end

  # TODO: fix case where block_given? returns true
  describe '.branches' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/branches/',
        {},
        {}
      ).and_return(['branch1', 'branch2', 'branch3'])
    end

    context 'without a block' do
      it 'invokes the .request method' do
        repo.branches('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'invokes the .request method' do
        repo.branches('mock_username', 'mock_repo') { |branch| branch }
      end
    end
  end

  describe '.edit' do
    before do
      expect(repo).to receive(:request).with(
        :put,
        '/1.0/repositories/mock_username/mock_repo/',
        BitBucket::Repos::DEFAULT_REPO_OPTIONS.merge({ 'owner' => 'mock_owner' }),
        {}
      )
    end

    it 'should send a PUT request for the given repo' do
      repo.edit('mock_username', 'mock_repo', { 'owner' => 'mock_owner' })
    end
  end

  # TODO: make sure this gets documented in gem since it is not in official docs
  describe '.get' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo',
        {},
        {}
      )
    end

    it 'should send a GET request for the given repo' do
      repo.get('mock_username', 'mock_repo', {})
    end
  end

  describe '.list' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/user/repositories',
        {},
        {}
      ).and_return(['repo1', 'repo2' ,'repo3'])
    end

    # FIXME: this method belongs in the User class!
    context 'without a block' do
      it 'should send a GET request for the authenticated users repos' do
        repo.list
      end
    end

    context 'with a block' do
      it 'should send a GET request for the authenticated users repos' do
        repo.list { |repo| repo }
      end
    end
  end

  describe '.tags' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/tags/',
        {},
        {}
      ).and_return(['tag1', 'tag2' ,'tag3'])
    end

    context 'without a block' do
      it 'should send a GET request for the tags belonging to the given repo' do
        repo.tags('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'should send a GET request for the tags belonging to the given repo' do
        repo.tags('mock_username', 'mock_repo') { |tag| tag }
      end
    end
  end

  describe "getter methods" do
    it "returns an object of the correct class" do
      expect(repo.changesets).to be_a BitBucket::Repos::Changesets
      expect(repo.keys).to be_a BitBucket::Repos::Keys
      expect(repo.following).to be_a BitBucket::Repos::Following
      expect(repo.commits).to be_a BitBucket::Repos::Commits
      expect(repo.pull_request).to be_a BitBucket::Repos::PullRequest
      expect(repo.forks).to be_a BitBucket::Repos::Forks
      expect(repo.download).to be_a BitBucket::Repos::Download
    end
  end
end
