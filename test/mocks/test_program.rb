module TestObjects
  module Programs
    class TestProgram < Program
      @trigger = /test/

      def init
        @actions[/.*/] = lambda { |params| @responses[:test].random }
        @responses[:test] = [
          'Test response'
        ]
      end
    end
  end
end
