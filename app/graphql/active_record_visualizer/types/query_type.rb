module ActiveRecordVisualizer
  module Types
    class QueryType < Types::BaseObject
      # Add root-level fields here.
      # They will be entry points for queries on your schema.

      field :application, Types::ApplicationType, null: false
      def application
        Rails.application
      end
    end
  end
end
