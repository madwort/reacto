require 'spec_helper'

context Reacto::Trackable do
  context '.combine' do
    it 'combines the notifications of Trackables with different number of ' \
      'notifications using the passed combinator' do
      trackable1 = described_class.interval(0.3).take(4)
      trackable2 = described_class.interval(0.7, ('a'..'b').each)
      trackable3 = described_class.interval(0.5, ('A'..'C').each)

      trackable = described_class.combine(
        trackable1, trackable2, trackable3
      ) do |v1, v2, v3|
        "#{v1} : #{v2} : #{v3}"
      end

      subscription = attach_test_trackers(trackable)
      trackable.await(subscription)

      expect(test_data).to be == [
        '1 : a : A', '2 : a : A', '2 : a : B', '3 : a : B',
        '3 : b : B', '3 : b : C', '|'
      ]
    end
  end
end
