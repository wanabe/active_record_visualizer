module ActiveRecordVisualizer
  module Types
    class ApplicationType < Types::BaseObject
      field :model_classes, Types::ModelClassType.connection_type, null: false do
        argument :except, [String], required: false
        argument :target, [String], required: false
      end
      def model_classes(except: [], target: nil)
        Types::ModelClassType.filter(object, except: except, target: target)
      end

      field :text, String, null: false do
        argument :type, String, required: false
        argument :targetClasses, [String], required: true
        argument :targetAssociations, [String], required: true
      end
      def text(type: "mermaid", target_classes:, target_associations:)
        text = +""

        case type
        when "mermaid"
          text << "classDiagram"
          model_classes(target: target_classes).each do |model_class|
            associations = Types::ModelAssociationType.filter(model_class, target_classes: target_classes, target: target_associations)
            associations.each do |association|
              text << "\n#{model_class.name.gsub("::", "")} --> #{association.klass.name.gsub("::", "")} : #{association.name}"
            end
          end
        when "graphviz"
          text << <<~EOT
            digraph G {
              fontsize = 12
              node [fontsize = 8, shape = "record"]
              edge [fontsize = 8]

          EOT

          model_classes(target: target_classes).each do |model_class|
            normalized_class_name = model_class.name.gsub(":", "_COLON_")
            text << "  #{normalized_class_name} [ label = \"{#{model_class.name}|\\l}\"]\n"
            associations = Types::ModelAssociationType.filter(model_class, target_classes: target_classes, target: target_associations)
            unless associations.empty?
              text << "  edge [arrowhead = \"normal\"]\n" 
              associations.each do |association|
                normalized_associated_class_name = association.klass.name.gsub(":", "_COLON_")
                text << "  #{normalized_class_name} -> #{normalized_associated_class_name} [ label = \"#{association.name}\"]\n"
              end
            end
            text << "\n"
          end
          text << "}"
        else
          raise GraphQL::ExecutionError, "Unknown text type: #{type}"
        end

        text
      end
    end
  end
end
