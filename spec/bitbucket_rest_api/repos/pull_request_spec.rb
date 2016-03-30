require 'spec_helper'

describe BitBucket::Repos::PullRequest do
  subject { described_class.new }
  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/pullrequests',
        {},
        {}
      ).and_return(['pr1', 'pr2', 'pr3'])
    end

    context 'without a block' do
      it 'makes a GET request for all pull requests belonging to the repo' do
        subject.list('mock_user', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'makes a GET request for all pull requests belonging to the repo' do
        subject.list('mock_user', 'mock_repo') { |pr| pr }
      end
    end
  end

  describe '#participants' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        "/1.0/repositories/mock_user/mock_repo/pullrequests/mock_pull_request_id/participants",
        {},
        {}
      ).and_return(['participant1', 'participant2', 'participant3'])
    end

    context 'without a block' do
      it 'makes a GET request for all participants belonging to the repo' do
        subject.participants('mock_user', 'mock_repo', 'mock_pull_request_id')
      end
    end

    context 'with a block' do
      it 'makes a GET request for all participants belonging to the repo' do
        subject.participants('mock_user', 'mock_repo', 'mock_pull_request_id') { |p| p }
      end
    end
  end

  describe '#get' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        "/2.0/repositories/mock_user/mock_repo/pullrequests/mock_pull_request_id",
        {}
      )
    end

    it 'makes a GET request for the pull request belonging to the repo' do
      subject.get('mock_user', 'mock_repo', 'mock_pull_request_id')
    end
  end

  describe '#create' do
    before do
      @params = {
        title: "mock_pr_title",
        description: "mock_pull_request_description",
        source: {
          branch: {
            name: "mock_source_branch_name"
          },
          repository: {
            full_name: "mock_owner/mock_repo"
          }
        },
        destination: {
          branch: {
            name: "mock_destination_branch_name"
          },
          commit: {
            hash: "mock_uuid"
          }
        },
        close_source_branch: true
      }
    end

    it 'makes a POST request to create a new pull request' do
      expect(subject).to receive(:request).with(
        :post,
        '/2.0/repositories/mock_user/mock_repo/pullrequests',
        @params
      )

      subject.create('mock_user', 'mock_repo', @params)
    end

    it 'validates presence of required params' do
      expect do
      subject.create(
        'mock_user',
        'mock_repo',
        {
          title: "",
          description: "mock_pull_request_description",
          source: {
            branch: {
              name: "mock_source_branch_name"
            },
            repository: {
              full_name: "mock_owner/mock_repo"
            }
          },
          destination: {
            branch: {
              name: "mock_destination_branch_name"
            },
            commit: {
              hash: "mock_uuid"
            }
          },
          close_source_branch: true
        }
      )
      end.to raise_error
    end
  end

  describe '.put' do
    before do
      expect(subject).to receive(:request).with(
        :put,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id',
        {}
      )
    end

    it 'makes a PUT request for the given pull request' do
      subject.update('mock_user', 'mock_repo', 'mock_id')
    end
  end

  describe '.commits' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/commits',
        {}
      )
    end

    it 'makes a GET request for the commits' do
      subject.commits('mock_user', 'mock_repo', 'mock_id')
    end
  end

  describe '.commits' do
    before do
      expect(subject).to receive(:request).with(
        :post,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/approve',
        {}
      )
    end

    it 'makes a POST request' do
      subject.approve('mock_user', 'mock_repo', 'mock_id')
    end
  end

  describe '.delete_approval' do
    before do
      expect(subject).to receive(:request).with(
        :delete,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/approve',
        {}
      )
    end

    it 'makes a DELTE request' do
      subject.delete_approval('mock_user', 'mock_repo', 'mock_id')
    end
  end


  describe '.diff' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/diff',
        {}
      )
    end

    it 'makes a GET request for the diff of the pull request' do
      subject.diff('mock_user', 'mock_repo', 'mock_id')
    end
  end

  describe '.all_activity' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/activity',
        {}
      )
    end

    it 'makes a GET request' do
      subject.all_activity('mock_user', 'mock_repo')
    end
  end


  describe '.activity' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/activity',
        {}
      )
    end

    it 'makes a GET request' do
      subject.activity('mock_user', 'mock_repo', 'mock_id')
    end
  end


  describe '.accept_and_merge' do
    before do
      expect(subject).to receive(:request).with(
        :post,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/merge',
        {}
      )
    end

    it 'makes a POST request' do
      subject.merge('mock_user', 'mock_repo', 'mock_id')
    end
  end

  describe '.decline' do
    before do
      expect(subject).to receive(:request).with(
        :post,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/decline',
        {}
      )
    end

    it 'makes a POST request' do
      subject.decline('mock_user', 'mock_repo', 'mock_id')
    end
  end


  describe '.comments' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/comments',
        {}
      )
    end

    it 'makes a GET request' do
      subject.comments('mock_user', 'mock_repo', 'mock_id')
    end
  end

  describe '.comment' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/pullrequests/mock_id/comments/comment_id',
        {}
      )
    end

    it 'makes a GET request' do
      subject.comment('mock_user', 'mock_repo', 'mock_id', 'comment_id')
    end
  end
end
