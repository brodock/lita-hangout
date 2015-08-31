module Lita
  module Handlers
    class Hangout < Handler
      HANGOUT_PREFIX = 'https://plus.google.com/hangouts/_/'

      config :domain, type: String, required: true

      route(/hangout$/i, :hangout, command: true, help: { 'hangout' => t('help.hangout') })
      route(/hangout me$/i, :hangout_me, command: true, help: { 'hangout me' => t('help.hangout_me') })
      route(/hangout me (.+)/i, :hangout_me, command: true,
                                             help: { 'hangout me <topic>' => t('help.hangout_me_topic') })

      def hangout(response)
        response.reply hangout_url(Time.now.to_i)
      end

      def hangout_me(response)
        if response.match_data.size == 1
          response.reply hangout_url(response.user.name)
        else
          response.reply hangout_url(response.match_data[1])
        end
      end

      private

      def hangout_url(sufix)
        URI.join(HANGOUT_PREFIX, "#{config.domain}/", permalink(sufix)).to_s
      end

      def permalink(subject = '')
        subject.to_s.gsub(/[^[:alnum:]]/, ' ').strip.gsub(/\W+/, '-')
      end
    end

    Lita.register_handler(Hangout)
  end
end
