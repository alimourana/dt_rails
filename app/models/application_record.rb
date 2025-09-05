# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  concerning :ActiveAdmin3Intergration do
    class_methods do
      def ransackable_attributes(_auth_object = nil)
        authorizable_ransackable_attributes
      end

      def ransackable_associations(_auth_object = nil)
        authorizable_ransackable_associations
      end
    end
  end
end
