# frozen_string_literal: true

ActiveAdmin.register Citerne do
  menu priority: 4

  permit_params :plate_number, :chassis_number, :capacity, :status, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :plate_number
    column :chassis_number
    column :capacity
    column :status
    column :created_at
    actions
  end

  filter :plate_number
  filter :chassis_number
  filter :capacity
  filter :status

  form do |f|
    f.inputs do
      f.input :plate_number
      f.input :chassis_number
      f.input :capacity
      f.input :status, as: :select, collection: ['available', 'in_use', 'maintenance', 'out_of_service']
    end
    f.actions
  end
end
