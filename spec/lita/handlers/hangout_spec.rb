require 'spec_helper'

describe Lita::Handlers::Hangout, lita_handler: true do
  # Routes
  it { is_expected.to route_command('hangout').to(:hangout) }
  it { is_expected.to route_command('hangout me').to(:hangout_me_user) }
  it { is_expected.to route_command('hangout me whatever').to(:hangout_me_topic) }

  # Commands
  before(:each) { robot.config.handlers.hangout.domain = 'example.com' }
  let(:hangout_url) { Lita::Handlers::Hangout::HANGOUT_PREFIX + 'example.com/' }

  describe '#hangout' do
    it 'replies with a hangout url' do
      send_command('hangout')
      expect(replies.last).to include(hangout_url)
    end
  end

  describe '#hangout_me_user' do
    context 'when using default adapter' do
      before { send_command('hangout me') }

      it 'replies with a hangout url and the username appended' do
        expect(replies.last).to include(hangout_url + 'Test-User')
      end

      it 'includes a mention of current user as the topic' do
        expect(replies.last).to include('Test User')
      end
    end

    context 'when using slack adapter' do
      before do
        # Fake slack adapter
        registry.register_adapter(:slack, Lita::Adapters::Shell)
        send_command('hangout me')
      end

      it 'replies with a hangout url and the username appended' do
        expect(replies.last).to include(hangout_url + 'Test-User')
      end

      it 'includes a mention of current user as the topic' do
        expect(replies.last).to include('Test User')
      end
    end
  end

  describe '#hangout_me_topic' do
    context 'when using default adapter' do
      before { send_command('hangout me whatever you say') }

      it 'replies with a hangout url and the username appended' do
        expect(replies.last).to include(hangout_url + 'whatever-you-say')
      end

      it 'includes the topic in the message' do
        expect(replies.last).to include('whatever you say')
      end
    end

    context 'when using slack adapter' do
      before do
        # Fake slack adapter
        registry.register_adapter(:slack, Lita::Adapters::Slack)
        send_command('hangout me whatever you say')
      end

      it 'replies with a hangout url and the username appended' do
        expect(replies.last).to include(hangout_url + 'whatever-you-say')
      end

      it 'includes the topic in the message' do
        expect(replies.last).to include('whatever you say')
      end
    end
  end
end
