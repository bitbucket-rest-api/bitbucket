require 'spec_helper'

describe BitBucket::Repos::Webhooks, wip: true do
  subject { described_class.new }
  let(:post_put_params) do
    {
      'description' => 'mock_description',
      'url' => 'mock_url',
      'active' => true,
      'events' => ['repo:push']
    }
  end

  let(:missing_key_params) do
    {
      'description' => 'mock_description',
      'active' => true,
      'events' => ['repo:push']
    }
  end

  let(:blank_value_params) do
    {
      'description' => '',
      'url' => 'mock_url',
      'active' => true,
      'events' => ['repo:push']
    }
  end

  let(:bad_event_params) do
    {
      'description' => 'mock_description',
      'url' => 'mock_url',
      'active' => true,
      'events' => ['bad:event']
    }
  end

  let(:missing_events_params) do
    {
      'description' => 'mock_description',
      'url' => 'mock_url',
      'active' => true,
      'events' => []
    }
  end

  describe '#create' do
    context 'when required fields are missing from params' do
      context 'when a required key is missing' do
        it 'raises an instance of BitBucket::Error::RequiredParams' do
          expect do
            subject.create(
              'mock_username',
              'mock_repo',
              missing_key_params
            )
          end.to raise_error(BitBucket::Error::RequiredParams)
        end
      end

      context 'when values of required keys are blank' do
        it 'raises an instance of BitBucket::Error::RequiredParams' do
          expect do
            subject.create(
              'mock_username',
              'mock_repo',
              blank_value_params
            )
          end.to raise_error(
            BitBucket::Error::BlankValue,
            "The value for: 'description', cannot be blank :("
          )
        end
      end
    end

    it 'validates the given events' do
      allow(subject).to(receive(:request))

      expect do
        subject.create(
          'mock_username',
          'mock_repo',
          bad_event_params

        )
      end.to raise_error(
        BitBucket::Error::BadEvents,
        "The event: 'bad:event', does not exist :("
      )
    end

    it 'checks that at least one event is given' do
      allow(subject).to(receive(:request))

      expect do
        subject.create(
          'mock_username',
          'mock_repo',
          missing_events_params
        )
      end.to raise_error(
        BitBucket::Error::NoEvents,
        "At least one event is required, none given :("
      )
    end

    it 'makes a POST request to create a specific webhook' do
      expect(subject).to receive(:request).with(
        :post,
        '/2.0/repositories/mock_username/mock_repo/hooks',
        post_put_params,
        { headers: { "Content-Type" => "application/json" } }
      )

      subject.create(
        'mock_username',
        'mock_repo',
        post_put_params
      )
    end
  end

  describe '#list' do
    it 'makes a GET request for all the webhooks beloning to the given repo' do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_username/mock_repo/hooks',
        {},
        {}
      )

      subject.list('mock_username', 'mock_repo')
    end
  end

  describe '#get' do
    it 'makes a GET request for a specific webook' do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_username/mock_repo/hooks/mock_uuid',
        {},
        {}
      )

      subject.get('mock_username', 'mock_repo', 'mock_uuid')
    end
  end

  describe '#edit' do
    context 'when required fields are missing from params' do
      context 'when a required key is missing' do
        it 'raises an instance of BitBucket::Error::RequiredParams' do
          expect do
            subject.edit(
              'mock_username',
              'mock_repo',
              'mock_uuid',
              missing_key_params
            )
          end.to raise_error(BitBucket::Error::RequiredParams)
        end
      end

      context 'when values of required keys are blank' do
        it 'raises an instance of BitBucket::Error::RequiredParams' do
          expect do
            subject.edit(
              'mock_username',
              'mock_repo',
              'mock_uuid',
              blank_value_params
            )
          end.to raise_error(
            BitBucket::Error::BlankValue,
            "The value for: 'description', cannot be blank :("
          )
        end
      end
    end

    it 'validates the existence of the given events' do
      allow(subject).to(receive(:request))

      expect do
        subject.edit(
          'mock_username',
          'mock_repo',
          'mock_uuid',
          bad_event_params
        )
      end.to raise_error(
        BitBucket::Error::BadEvents,
        "The event: 'bad:event', does not exist :("
      )
    end

    it 'validates that at least one event is given' do
      allow(subject).to(receive(:request))

      expect do
        subject.edit(
          'mock_username',
          'mock_repo',
          'mock_uuid',
          missing_events_params
        )
      end.to raise_error(
        BitBucket::Error::NoEvents,
        "At least one event is required, none given :("
      )
    end

    it 'makes a PUT request for the given webhook' do
      expect(subject).to receive(:request).with(
        :put,
        '/2.0/repositories/mock_username/mock_repo/hooks/mock_uuid',
        post_put_params,
        { headers: { "Content-Type" => "application/json" } }
      )

      subject.edit(
        'mock_username',
        'mock_repo',
        'mock_uuid',
        post_put_params
      )
    end
  end

  describe '#delete' do
    it 'sends a DELETE request for the given webhook' do
      expect(subject).to receive(:request).with(
        :delete,
        '/2.0/repositories/mock_username/mock_repo/hooks/mock_uuid',
        {},
        {}
      )

      subject.delete('mock_username', 'mock_repo', 'mock_uuid')
    end
  end
end
