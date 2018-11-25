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
        ActiveRecord::Base.descendants.select {|klass| !except.include?(klass.name) }.sort_by(&:name)
      end
    end
  end
end
