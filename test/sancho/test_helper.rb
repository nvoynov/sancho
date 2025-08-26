require_relative '../test_helper'

module SanchoHelper
  def config = Task::ReadConfig.run
end
