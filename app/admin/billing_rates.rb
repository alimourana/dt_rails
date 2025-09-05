# frozen_string_literal: true

ActiveAdmin.register BillingRate do
  menu priority: 7

  permit_params :name, :rate_per_hour, :rate_per_km, :description, :active, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :origin
    column :destination
    column :rate
    column :created_at
    actions
  end

  filter :origin
  filter :destination
  filter :rate
  filter :created_at

  form do |f|
    f.inputs do
      f.input :origin
      f.input :destination
      f.input :rate
    end
    f.actions
  end
end
