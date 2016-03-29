require 'spec_helper'

describe BitBucket do
  let(:method) { 'create_repos'}
  let(:alt_method) { 'repos.create'}

  it { expect(described_class.constants).to include :DEPRECATION_PREFIX }

  context '.deprecate' do
    before do
      BitBucket.deprecation_tracker = []
    end

    it 'tracks messages' do
      expect(BitBucket).to receive(:warn).once()
      BitBucket.deprecate(method)
      BitBucket.deprecate(method)
    end

    it 'prints the message through Kernel' do
      expect(BitBucket).to receive(:warn).once()
      BitBucket.deprecate method
    end
  end

  it 'prints the message through Kernel' do
    expect(BitBucket).to receive(:warn)
    BitBucket.warn_deprecation method
  end
end
