module ActiveRecordVisualizer
  module Types
    class ApplicationQueryInputType < Types::BaseInputObject
      argument :disable, [String], required: true
    end
  end
end
