require 'reacto/constants'
require 'reacto/subscriptions/combining_subscription'

module Reacto
  module Subscriptions
    class ZippingSubscription < CombiningSubscription
      def subscribed?
        @subscriptions.all? { |s| s.subscribed? }
      end

      def on_value(v)
        super(v)

        # TODO There is need of a common parent of the combining and
        # zipping subscriptions
        return if @subscriptions.map(&:last_value).any? { |vl| vl == NO_VALUE }
        @subscriptions.each { |sub| sub.last_value = NO_VALUE }
      end

      def on_close
        return unless subscribed?

        @subscriber.on_close
      end
    end
  end
end