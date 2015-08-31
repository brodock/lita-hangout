require 'spec_helper'

describe Lita::Handlers::Hangout, lita_handler: true do
  # Routes
  it { is_expected.to route_command('hangout').to(:hangout) }
  it { is_expected.to route_command('hangout me').to(:hangout_me) }
  it { is_expected.to route_command('hangout me whatever').to(:hangout_me) }

  # Commands
  before(:each) { robot.config.handlers.hangout.domain = 'example.com' }
  let(:hangout_url) { Lita::Handlers::Hangout::HANGOUT_PREFIX + 'example.com/' }

  describe '#hangout' do
    it 'replies with a hangout url' do
      send_command('hangout')
      expect(replies.last).to include(hangout_url)
    end
  end

  describe '#hangout_me' do
    it 'replies with a hangout url' do
      send_command('hangout me')
      expect(replies.last).to include(hangout_url)
    end

    context 'when no argument is informed' do
      it 'replies with a hangout url and the username appended' do
        send_command('hangout me')
        expect(replies.last).to eq(hangout_url + 'Test-User')
      end
    end

    context 'when argument is informed' do
      it 'replies with a hangout url and the username appended' do
        send_command('hangout me whatever you say')
        expect(replies.last).to eq(hangout_url + 'whatever-you-say')
      end
    end
  end
end
