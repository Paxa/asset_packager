require 'synthesis'

if defined?(RAILS_GEM_VERSION) && RAILS_GEM_VERSION =~ /2\.3\./
  require 'synthesis/asset_package'
  require 'synthesis/asset_package_helper'
  ActionView::Base.send :include, Synthesis::AssetPackageHelper
else
  require 'rails'

  module Synthesis
    class Railtie < Rails::Railtie
    
      config.after_initialize do
        ActiveSupport.on_load :action_view do
          ActionView::Base.send :include, Synthesis::AssetPackageHelper
        end
      end

      rake_tasks do
        load "tasks/asset_packager_tasks.rake"
      end
    end
  end
end