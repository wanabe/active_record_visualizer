module ActiveRecordVisualizer
  module Types
    class ModelAssociationType < Types::BaseObject
      field :name, String, null: false
      field :klass, String, null: false
      def klass
        object.klass rescue nil
      end

      def self.filter(parent, except_classes: [], except: [], target_classes: nil, target: nil)
        associations = parent.reflect_on_all_associations
        associations.select! do |association|
          association.klass rescue next nil
          next false if except_classes.include?(association.active_record.name)
          next false if except_classes.include?(association.klass.name)
          if target_classes
            next false if !target_classes.include?(association.active_record.name)
            next false if !target_classes.include?(association.klass.name)
          end
          next false if except.include?("#{association.active_record.name}##{association.name}")
          next false if target && !target.include?("#{association.active_record.name}##{association.name}")
          true
        end
        associations.sort_by!(&:name)
        associations
      end
    end
  end
end
