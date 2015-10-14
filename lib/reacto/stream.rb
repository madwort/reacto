
module Reacto
  class Stream

    def on(type = :value, listener)
      listeners(type) << listener
    end

    private

    def listeners(type = :value)
      @listeners ||= {}
      @listeners[type] ||= []

      @listeners[type]
    end

    def notify(type = :value)
      listeners(type).each(&:call)
    end
  end
end
