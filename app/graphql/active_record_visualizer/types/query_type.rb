module ActiveRecordVisualizer
  module Types
    class QueryType < Types::BaseObject
      # Add root-level fields here.
      # They will be entry points for queries on your schema.

      field :model_classes, Types::ModelClassType.connection_type, null: false do
        argument :except, [String], required: false
        argument :target, [String], required: false
      end
      def model_classes(except: [], target: nil)
        Types::ModelClassType.filter(self, except: except, target: target)
      end
    end
  end
end
