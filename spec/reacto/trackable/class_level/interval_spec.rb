require 'spec_helper'

context Reacto::Trackable do
  context '.interval' do
    it 'emits an infinite sequence of number on every n seconds by default' do
      trackable = described_class.interval(0.1)
      subscription = attach_test_trackers(trackable)
      sleep 1
      subscription.unsubscribe

      expect(test_data).to be == (0..8).to_a
    end

    it 'can use any enumerator to produce the sequence to emit' do
      trackable = described_class.interval(0.1, ('a'..'z').each)
      subscription = attach_test_trackers(trackable)
      sleep 1
      subscription.unsubscribe

      expect(test_data).to be == ('a'..'i').to_a
    end

    it 'can use the immediate executor to block the current thread while ' \
      'emitting' do
      trackable = described_class.interval(
        0.1, (1..5).each, executor: Reacto::Executors.immediate
      )
      subscription = attach_test_trackers(trackable)

      expect(test_data).to be == (1..5).to_a + ['|']
    end
  end
end