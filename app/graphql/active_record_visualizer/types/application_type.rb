module ActiveRecordVisualizer
  module Types
    class ApplicationType < Types::BaseObject
      field :model_classes, Types::ModelClassType.connection_type, null: false
    end
  end
end
