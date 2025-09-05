# frozen_string_literal: true

ActiveAdmin.register OauthApplication do
  menu priority: 9

  permit_params :name, :uid, :secret, :redirect_uri, :scopes, :confidential, :owner_id, :owner_type, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :uid
    column :redirect_uri
    column :scopes
    column :confidential
    column :owner do |app|
      app.owner&.email if app.owner
    end
    column :created_at
    actions
  end

  filter :name
  filter :uid
  filter :redirect_uri
  filter :scopes
  filter :confidential
  filter :owner_id, as: :select, collection: User.all.map { |u| [u.email, u.id] }
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :uid
      f.input :secret
      f.input :redirect_uri
      f.input :scopes
      f.input :confidential
      f.input :owner_type, as: :select, collection: ['User'], selected: 'User'
      f.input :owner_id, as: :select, collection: User.all.map { |u| [u.email, u.id] }, label: 'Owner'
    end
    f.actions
  end
end
