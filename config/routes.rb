ActiveRecordVisualizer::Engine.routes.draw do
  post "/graphql", to: "graphql#execute"
  root to: "front_end#index"
end
