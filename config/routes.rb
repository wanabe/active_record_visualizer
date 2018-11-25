ActiveRecordVisualizer::Engine.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/active_record_visualizer/graphql"
  end
  post "/graphql", to: "graphql#execute"
  root to: "front_end#index"
end
