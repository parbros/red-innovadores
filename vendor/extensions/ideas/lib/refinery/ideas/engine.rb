module Refinery
  module Ideas
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Ideas

      engine_name :refinery_ideas

      initializer "register refinerycms_ideas plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "ideas"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.ideas_admin_ideas_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/ideas/idea'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Ideas)
      end
    end
  end
end
