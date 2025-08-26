module Sancho
  module_function

  VERSION = '0.7.1'
  
  def root
    File.expand_path(File.dirname(__dir__))
  end

  def assets
    File.join(root, LAYOUTS_DIR)
  end

  CONFIG_FILE = '.sancho.yml'

  LAYOUTS_DIR = '_layouts'

  DEFAULT_SITE_DIR = 'docs'

  DEFAULT_SITE_DOMAIN = 'domain'

  DEFAULT_SITE_TITLE = 'Sancho'
end

# puts Sancho.root, Sancho.assets
