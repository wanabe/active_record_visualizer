Rails.application.routes.draw do
  mount ActiveRecordVisualizer::Engine => "/active_record_visualizer"
end
