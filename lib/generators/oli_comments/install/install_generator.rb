require 'generators/oli_comments/helpers'

module OliComments
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include OliComments::Generators::Helpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Installs Oli Comments into the application, creates the routes & configuration necessary to integrate it."

      def create_initializer
        template "initializer.rb", File.join('config','initializers','oli_comments.rb')
      end

      def mount_engine
        inject_into_file routes_path, :after => "application.routes.draw do\n" do
          "  mount OliComments::Engine => '/' \n"
        end
      end
      
      def add_style
        insert_into_file "app/assets/stylesheets/application.css.scss", :before => "*/" do
          "\n *= require 'oli_comments'\n\n"
        end
      end 
      
      def add_js
        insert_into_file "app/assets/javascripts/application.js", :before => "//= require_tree ." do
          "\n//= require oli_comments\n"
        end
      end

    end
  end
end
