# frozen_string_literal: true

require "test_helper"

class TestSancho < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sancho::VERSION
  end

  def test_helpers
    Sancho.root
    Sancho.assets
    Sancho.docs
    Sancho.tasks
  end
end
