# frozen_string_literal: true

ActiveAdmin.register Document do
  menu priority: 6

  permit_params :title, :document_type, :file_path, :description, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :title
    column :document_type
    column :file_path
    column :description
    column :created_at
    actions
  end

  filter :title
  filter :document_type
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :document_type, as: :select, collection: ['invoice', 'contract', 'report', 'other']
      f.input :file_path
      f.input :description, as: :text
    end
    f.actions
  end
end
