require_relative 'test_helper'

describe 'exe/sancho' do

  it '#help' do
    out, _ = capture_subprocess_io{
      system 'exe/sancho help'
    }
    assert_match 'Sancho', out
  end

end
