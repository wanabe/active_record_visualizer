require "webpacker"

module ActiveRecordVisualizer
  class Engine < ::Rails::Engine
    isolate_namespace ActiveRecordVisualizer

    initializer "active_record_visualizer.bootstrap", before: "webpacker.bootstrap" do
      root_path = ActiveRecordVisualizer::Engine.root
      config_path = root_path.join "config/webpacker.yml"
      Webpacker.instance = Webpacker::Instance.new root_path: root_path, config_path: config_path
    end

    initializer "active_record_visualizer.initialize" do |app|
      app.eager_load!
    end

    initializer "active_record_visualizer.helper" do
      ActiveSupport.on_load :action_controller do
        ActionController::Base.helper Webpacker::Helper
      end

      ActiveSupport.on_load :action_view do
        include Webpacker::Helper
      end
    end

    initializer "active_record_visualizer.proxy" do |app|
      insert_middleware = Webpacker.config.dev_server.present? rescue nil
      if insert_middleware
        app.middleware.insert_before 0, Webpacker::DevServerProxy, ssl_verify_none: true
        app.middleware.insert_before 0, ::ActionDispatch::Static, "#{root}/public"
      end
    end
  end
end
