require 'spec_helper'

describe BitBucket::Repos::Sources do
  let(:subject) { BitBucket::Repos::Sources.new }

  describe '#list' do
    context 'when some parameters are missing' do
      it 'raises an error' do
        expect do
          subject.list(
            'mock_username',
            'mock_repo'
          )
        end.to raise_error(ArgumentError)
      end
    end

    context 'when path parameter is empty' do
      before do
        expect(subject).to receive(:request).with(
          :get,
          '/2.0/repositories/mock_username/mock_repo/src/moch_sha/',
          {},
          {}
        )
      end

      it 'sends a GET request for a list of all source files' do
        subject.list('mock_username', 'mock_repo', 'moch_sha', '')
      end
    end

    context 'when path parameter is defined' do
      before do
        expect(subject).to receive(:request).with(
          :get,
          '/2.0/repositories/mock_username/mock_repo/src/moch_sha/app/controller',
          {},
          {}
        )
      end

      it 'send a GET request for a list of the source files under the specified path' do
        subject.list('mock_username', 'mock_repo', 'moch_sha', 'app/controller')
      end
    end
  end

  describe '#get' do
    context 'when some parameters are missing' do
      it 'raises an error' do
        expect do
          subject.get(
            'mock_username',
            'mock_repo',
            'moch_sha'
          )
        end.to raise_error(ArgumentError)
      end
    end

    context 'when path parameter is defined' do
      before do
        expect(subject).to receive(:request).with(
          :get,
          '/2.0/repositories/mock_username/mock_repo/raw/moch_sha/app/assets/images/logo.jpg',
          {},
          {}
        )
      end

      it "send a GET request for a source file's size and contents" do
        subject.get('mock_username', 'mock_repo', 'moch_sha', 'app/assets/images/logo.jpg')
      end
    end
  end
end
