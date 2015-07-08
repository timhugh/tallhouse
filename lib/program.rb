class Program
  class << self
    attr_reader :trigger
  end

  def initialize
    init if methods.include?(:init)
  end

  def action(trigger, &block)
    @actions = {} if @actions.nil?
    fail if @actions.keys.include? trigger
    @actions[trigger] = block
  end

  def add_response(key, *message)
    @responses = {} if @responses.nil?
    @responses[key] = [] if @responses[key].nil?
    @responses[key] |= message
  end

  def respond(params = {})
    body = params[:Body] || params['Body']
    @actions.each do |pattern, action|
      return action.call(params) if body[pattern]
    end
  end

  def response(key)
    @responses[key].random
  end
end