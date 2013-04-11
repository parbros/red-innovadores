module Refinery
  module Covers
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Covers

      engine_name :refinery_covers

      initializer "register refinerycms_covers plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "covers"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.covers_admin_covers_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/covers/cover'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Covers)
      end
    end
  end
end
