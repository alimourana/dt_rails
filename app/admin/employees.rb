# frozen_string_literal: true

ActiveAdmin.register Employee do
  menu priority: 2

  permit_params :matricule, :first_name, :last_name, :email, :phone, :position, :department, :hire_date, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :matricule
    column :first_name
    column :last_name
    column :email
    column :phone
    column :position
    column :department
    column :hire_date
    column :created_at
    actions
  end

  filter :matricule
  filter :first_name
  filter :last_name
  filter :email
  filter :position
  filter :department
  filter :hire_date

  form do |f|
    f.inputs do
      f.input :matricule
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :position
      f.input :department
      f.input :hire_date, as: :date_picker
    end
    f.actions
  end
end
