require_relative '../test_helper'
require 'rake'
source, folders = Sancho.tasks
Rake.application.rake_require source, folders

class TestRakeTasks < Minitest::Test
  def invoke_task(name)
    Rake::Task[name].reenable
    Rake.application.invoke_task name
  end

  def test_init
    Tempbox.() {
      capture_io {
        invoke_task 'sancho:init'
        assert File.exist?(Conf::CONF)
        assert Dir.exist?(LAYOUT)
        refute Dir.empty?(LAYOUT)
      }
    }
  end

  def test_docs
    Tempbox.() {
      File.write('README.md', '% README')
      File.write('CHANGELOG.md', '% CHANGELOG')
      capture_io {
        invoke_task 'sancho:init'
        invoke_task 'sancho:docs'
        assert Dir.exist?(Sancho::DOCS)

        joinfu = proc{|arg| File.join(Sancho::DOCS, arg)}
        testfu = proc{|arg| assert File.exist?(arg)}
        %w[index.html readme.html changelog.html robots.txt sitemap.xml
        ].map(&joinfu).each(&testfu)
      }
    }
  end

end
