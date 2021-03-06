require "stimulus/importmap_helper"

module Stimulus
  class Engine < ::Rails::Engine
    isolate_namespace Stimulus
    config.eager_load_namespaces << Stimulus

    initializer "stimulus.assets" do
      Rails.application.config.assets.precompile += %w( importmap.json stimulus/manifest )
    end

    initializer "stimulus.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper Stimulus::Engine.helpers
      end

      Rails.application.config.assets.configure do |env|
        env.context_class.class_eval { include Stimulus::ImportmapHelper }
      end
    end
  end
end
