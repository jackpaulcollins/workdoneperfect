# frozen_string_literal: true

require "pagy/extras/array"

module Jumpstart
  class DocsController < ::ApplicationController
    def deploying
      @render_yaml_contents = File.read("render.yaml") if File.exist?("render.yaml")
    end

    def icons
      @icons = Dir.chdir(Rails.root.join("app/assets/images")) do
        Dir.glob("icons/*.svg").sort
      end
    end

    def pagination
      @pagy, = pagy_array([nil] * 1000)
    end
  end
end
