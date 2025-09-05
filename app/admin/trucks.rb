# frozen_string_literal: true

ActiveAdmin.register Truck do
  menu priority: 3

  permit_params :make, :model, :plate_number, :status, :vin, :employee_id, :citernes_id, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :plate_number
    column :make
    column :model
    column :status
    column :vin
    column :employee do |truck|
      truck.employee&.full_name if truck.employee
    end
    column :citerne do |truck|
      truck.citerne&.plate_number if truck.citerne
    end
    column :created_at
    actions
  end

  filter :plate_number
  filter :make
  filter :model
  filter :status
  filter :vin
  filter :employee

  form do |f|
    f.inputs do
      f.input :plate_number
      f.input :make
      f.input :model
      f.input :vin
      f.input :status, as: :select, collection: ['available', 'in_use', 'maintenance', 'out_of_service']
      f.input :employee, as: :select, collection: Employee.all.map { |e| [e.full_name, e.id] }
      f.input :citerne, as: :select, collection: Citerne.all.map { |c| [c.plate_number, c.id] }
    end
    f.actions
  end
end
