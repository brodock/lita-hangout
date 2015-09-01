module Lita
  module Handlers
    class Hangout < Handler
      HANGOUT_PREFIX = 'https://plus.google.com/hangouts/_/'

      config :domain, type: String, required: true

      route(/hangout$/i, :hangout, command: true, help: { 'hangout' => t('help.hangout') })
      route(/hangout me$/i, :hangout_me_user, command: true, help: { 'hangout me' => t('help.hangout_me') })
      route(/hangout me (.+)/i, :hangout_me_topic, command: true,
                                                   help: { 'hangout me <topic>' => t('help.hangout_me_topic') })

      def hangout(response)
        response.reply hangout_url(Time.now.to_i)
      end

      def hangout_me_user(response)
        name = response.user.name
        url = hangout_url(name)
        text = render_template('hangout_user', url: url, name: name)

        case robot.config.robot.adapter
        when :slack
          title = t('messages.hangout_me_user', name: name)
          reply_with_attachment(response, url, title: title, fallback: text)
        else
          response.reply text
        end
      end

      def hangout_me_topic(response)
        topic = response.match_data[1]
        url = hangout_url(topic)
        text = render_template('hangout_topic', url: hangout_url(topic), topic: topic)

        case robot.config.robot.adapter
        when :slack
          title = t('messages.hangout_me_topic', topic: topic)
          reply_with_attachment(response, url, title: title, fallback: text)
        else
          response.reply text
        end
      end

      private

      def hangout_url(sufix)
        URI.join(HANGOUT_PREFIX, "#{config.domain}/", permalink(sufix)).to_s
      end

      def permalink(subject = '')
        subject.to_s.gsub(/[^[:alnum:]]/, ' ').strip.gsub(/\W+/, '-')
      end

      def reply_with_attachment(response, *attachment_params)
        target = response.message.source.room_object || response.message.source.user
        robot.chat_service.send_attachment(target, Lita::Adapters::Slack::Attachment.new(*attachment_params))
      end
    end

    Lita.register_handler(Hangout)
  end
end
