require "modulate/engine"

module Modulate

  extend self

  def application_namespace
    Rails.application.class.name.split('::').first
  end

  def configuration
    @configuration || configure
  end

  def configure
    @configuration = Configuration.new
    yield(@configuration) if block_given?
    @configuration
  end
end
