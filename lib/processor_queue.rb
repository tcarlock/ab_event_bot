module EventScraper
  class ProcessorQueue
    def initialize(&block)
      @stack = []
      instance_eval(&block) if block_given?
    end

    def use(klass)
      @stack << klass.new
    end

    def process(url)
      @stack.each do |klass| 
        events = klass.process url

        return events unless events.nil?
      end
    end
  end
end