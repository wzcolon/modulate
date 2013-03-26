module Modulate
  class Configuration

    attr_accessor :user_method

    def initialize(method = nil)
      @user_method = method
    end
  end
end
