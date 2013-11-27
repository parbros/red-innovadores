module Refinery
  module Gamifications
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Gamifications

      engine_name :refinery_gamifications

      initializer "register refinerycms_gamifications plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "gamifications"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.gamifications_admin_gamifications_path }
          plugin.pathname = root
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Gamifications)
      end
    end
  end
end
