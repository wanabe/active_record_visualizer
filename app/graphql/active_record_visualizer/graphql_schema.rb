require "graphql"

module ActiveRecordVisualizer
  class GraphqlSchema < GraphQL::Schema
    mutation(Types::MutationType)
    query(Types::QueryType)
  end
end
