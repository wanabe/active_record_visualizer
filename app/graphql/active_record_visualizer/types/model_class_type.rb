module ActiveRecordVisualizer
  module Types
    class ModelClassType < Types::BaseObject
      field :name, String, null: false
      field :associations, Types::ModelAssociationType.connection_type, null: false do
        argument :exceptClasses, [String], required: false
        argument :except, [String], required: false
      end
      def associations(except_classes: [], except: [])
        Types::ModelAssociationType.filter(self, except_classes: except_classes, except: except)
      end

      def self.filter(parent, except: [])
        Rails.application.eager_load!
        model_classes = ActiveRecord::Base.descendants
        model_classes.select! do |klass|
          next false if except.include?(klass.name)
          true
        end
        model_classes.sort_by!(&:name)
        model_classes
      end
    end
  end
end
