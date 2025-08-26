require_relative '../test_helper'

describe Task::CopyAssets do
  include SanchoHelper
  let(:subject) { Task::ReadConfig }

  it '#run' do
    Tempbox.call {
      capture_io {
        refute File.exist?(Sancho::CONFIG_FILE)
        config = subject.run
        assert File.exist?(Sancho::CONFIG_FILE)
        assert_kind_of Model::Config, config
        
        # read default config
        config = subject.run

        # read broken config
        File.write(Sancho::CONFIG_FILE, 'faulty content') 
        faulty = subject.run

        assert_equal config, faulty
      }      
    }
  end
end
