require_dependency "active_record_visualizer/application_controller"

module ActiveRecordVisualizer
  class FrontEndController < ApplicationController
    def index
      render body: nil
    end
  end
end
