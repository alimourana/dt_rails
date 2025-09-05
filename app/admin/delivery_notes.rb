# frozen_string_literal: true

ActiveAdmin.register DeliveryNote do
  menu priority: 5

  permit_params :number, :status, :origin, :destination, :gasoline_quantity, :diesel_quantity, :total_quantity, :missing_quantity, :missing_description, :updated_by, :created_by, :issued_date, :delivery_date, :return_date, :employee_id, :truck_id, :citernes_id, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :number
    column :status
    column :origin
    column :destination
    column :total_quantity
    column :missing_quantity
    column :truck do |note|
      note.truck&.plate_number if note.truck
    end
    column :employee do |note|
      note.employee&.full_name if note.employee
    end
    column :issued_date
    column :delivery_date
    column :created_at
    actions
  end

  filter :number
  filter :status
  filter :origin
  filter :destination
  filter :truck
  filter :employee
  filter :issued_date
  filter :delivery_date
  filter :created_at

  form do |f|
    f.inputs do
      f.input :number
      f.input :status, as: :select, collection: ['pending', 'in_transit', 'delivered', 'returned', 'cancelled']
      f.input :origin
      f.input :destination
      f.input :gasoline_quantity
      f.input :diesel_quantity
      f.input :total_quantity
      f.input :missing_quantity
      f.input :missing_description, as: :text
      f.input :updated_by
      f.input :created_by
      f.input :issued_date, as: :date_picker
      f.input :delivery_date, as: :date_picker
      f.input :return_date, as: :date_picker
      f.input :truck, as: :select, collection: Truck.all.map { |t| [t.plate_number, t.id] }
      f.input :employee, as: :select, collection: Employee.all.map { |e| [e.full_name, e.id] }
      f.input :citerne, as: :select, collection: Citerne.all.map { |c| [c.plate_number, c.id] }
    end
    f.actions
  end
end
