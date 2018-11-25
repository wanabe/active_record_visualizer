module ActiveRecordVisualizer
  module Types
    class ModelAssociationType < Types::BaseObject
      field :name, String, null: false
      field :klass, String, null: false
      def klass
        object.klass rescue nil
      end

      def self.filter(parent, except_classes: [], except: [])
        parent.object.reflect_on_all_associations.select do |association|
          association.klass rescue next nil
          next false if except_classes.include?(association.active_record.name)
          next false if except_classes.include?(association.klass.name)
          next false if except.include?("#{association.active_record.name}##{association.name}")
          true
        end.sort_by(&:name)
      end
    end
  end
end
