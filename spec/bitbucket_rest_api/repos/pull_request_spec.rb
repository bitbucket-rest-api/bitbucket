require 'spec_helper'

describe BitBucket::Repos::PullRequest do
  subject { described_class.new }
  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_username/mock_repo/pullrequests',
        {},
        {}
      )
    end

    it 'makes a GET request for all pull requests belonging to the repo' do
      subject.list('mock_username', 'mock_repo')
    end
  end

  describe '#participants' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        "/1.0/repositories/mock_username/mock_repo/pullrequests/mock_pull_request_id/participants",
        {},
        {}
      )
    end

    it 'makes a GET request for all participants belonging to the repo' do
      subject.participants('mock_username', 'mock_repo', 'mock_pull_request_id')
    end
  end

  describe '#get' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        "/2.0/repositories/mock_username/mock_repo/pullrequests/mock_pull_request_id",
        {},
        {}
      )
    end

    it 'makes a GET request for the pull request belonging to the repo' do
      subject.get('mock_username', 'mock_repo', 'mock_pull_request_id')
    end
  end

  describe '#create' do
    before do
      # expect(subject).to receive(:request).with(
      #   :post,
      #   '/2.0/repositories/mock_username/mock_repo/pullrequests',
      #   {
      #     title: "mock_pr_title",
      #     description: "mock_pull_request_description",
      #     source: {
      #       branch: {
      #         name: "mock_source_branch_name"
      #       },
      #       repository: {
      #         full_name: "mock_owner/mock_repo"
      #       }
      #     },
      #     destination: {
      #       branch: {
      #         name: "mock_destination_branch_name"
      #       },
      #       commit: {
      #         hash: "mock_uuid"
      #       }
      #     },
      #     close_source_branch: true
      #   },
      #   {}
      # )
    end

    it 'validates presence of required params' do
      # expect do
        subject.create(
          'mock_username',
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
      # end.to(raise_error())
    end

    it 'makes a POST request to create a new pull request' do
    end
  end
end
