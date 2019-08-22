module OliComments
  class Engine < ::Rails::Engine
    isolate_namespace OliComments
    
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
    
    initializer 'oli_comments.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper CommentsHelper
      end
    end
    
  end
end
