module Refinery
  module Experiences
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Experiences

      engine_name :refinery_experiences

      initializer "register refinerycms_experiences plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "experiences"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.experiences_admin_experiences_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/experiences/experience'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Experiences)
      end
    end
  end
end
