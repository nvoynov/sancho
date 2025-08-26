require_relative 'test_helper'

class TestCLI < Minitest::Test
  def test_init  
    Tempbox.call {
      capture_io {
        File.write('README.md', '% README')
        File.write('CHANGELOG.md', '% CHANGELOG')
        CLI.init
        # puts Dir['**/*']
      }
      assert Dir.exist?(Sancho::LAYOUTS_DIR)
    }
  end

  def test_build
    Tempbox.call {
      capture_io {
        File.write('README.md', '% README')
        File.write('CHANGELOG.md', '% CHANGELOG')
        CLI.init
        CLI.build
        # puts Dir['**/*']        
      }
      config = Sancho::Task::ReadConfig.run
      assert Dir.exist?(config.directory)
      refute Dir[File.join(config.directory, '**/*')].empty?
    }
  end
end
