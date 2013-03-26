module Modulate
  class Configuration

    attr_accessor :user_method

    def initialize
      @user_method = :current_user
    end
  end
end
