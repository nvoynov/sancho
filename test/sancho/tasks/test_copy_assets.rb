require_relative '../test_helper'

describe Task::CopyAssets do
  include SanchoHelper
  let(:subject) { Task::CopyAssets }

  it '#run' do
    Tempbox.call {
      capture_io {
        subject.run
        assert Dir.exist?(Sancho::LAYOUTS_DIR)
        refute Dir.empty?(Sancho::LAYOUTS_DIR)
      }      
      # puts Dir['**/*.*']
    }
  end
end
