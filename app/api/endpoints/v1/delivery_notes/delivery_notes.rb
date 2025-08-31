# frozen_string_literal: true

# module API
#   module V1
#     class DeliveryNotes < Grape::API
#       # before { authenticate! }

#       resource :delivery_notes do
#         desc 'Get all delivery notes'
#         get do
#           delivery_notes = DeliveryNote.includes(:employee, :truck, :citerne).all
#           present delivery_notes, with: DeliveryNoteEntity::Base
#         end

#         desc 'Get a specific delivery note'
#         params do
#           requires :id, type: Integer, desc: 'Delivery Note ID'
#         end
#         get ':id' do
#           delivery_note = DeliveryNote.includes(:employee, :truck, :citerne).find(params[:id])
#           present delivery_note, with: DeliveryNoteEntity::Base
#         end

#         desc 'Create a new delivery note'
#         params do
#           requires :number, type: String, desc: 'Delivery note number'
#           requires :status, type: String, desc: 'Status'
#           requires :origin, type: String, desc: 'Origin'
#           requires :destination, type: String, desc: 'Destination'
#           requires :gasoline_quantity, type: String, desc: 'Gasoline quantity'
#           requires :diesel_quantity, type: String, desc: 'Diesel quantity'
#           requires :total_quantity, type: String, desc: 'Total quantity'
#           requires :missing_quantity, type: String, desc: 'Missing quantity'
#           requires :missing_description, type: String, desc: 'Missing description'
#           requires :updated_by, type: String, desc: 'Updated by'
#           requires :created_by, type: String, desc: 'Created by'
#           requires :issued_date, type: Date, desc: 'Issued date'
#           requires :delivery_date, type: Date, desc: 'Delivery date'
#           requires :return_date, type: Date, desc: 'Return date'
#           optional :employee_id, type: Integer, desc: 'Employee ID'
#           optional :truck_id, type: Integer, desc: 'Truck ID'
#           optional :citerne_id, type: Integer, desc: 'Citerne ID'
#         end
#         post do
#           delivery_note = DeliveryNote.create!(declared(params))
#           present delivery_note, with: DeliveryNoteEntity::Base
#         end

#         desc 'Update a delivery note'
#         params do
#           requires :id, type: Integer, desc: 'Delivery Note ID'
#           optional :status, type: String, desc: 'Status'
#           optional :origin, type: String, desc: 'Origin'
#           optional :destination, type: String, desc: 'Destination'
#           optional :gasoline_quantity, type: String, desc: 'Gasoline quantity'
#           optional :diesel_quantity, type: String, desc: 'Diesel quantity'
#           optional :total_quantity, type: String, desc: 'Total quantity'
#           optional :missing_quantity, type: String, desc: 'Missing quantity'
#           optional :missing_description, type: String, desc: 'Missing description'
#           optional :updated_by, type: String, desc: 'Updated by'
#           optional :issued_date, type: Date, desc: 'Issued date'
#           optional :delivery_date, type: Date, desc: 'Delivery date'
#           optional :return_date, type: Date, desc: 'Return date'
#           optional :employee_id, type: Integer, desc: 'Employee ID'
#           optional :truck_id, type: Integer, desc: 'Truck ID'
#           optional :citerne_id, type: Integer, desc: 'Citerne ID'
#         end
#         put ':id' do
#           delivery_note = DeliveryNote.find(params[:id])
#           delivery_note.update!(declared(params, include_missing: false))
#           present delivery_note, with: DeliveryNoteEntity::Base
#         end

#         desc 'Delete a delivery note'
#         params do
#           requires :id, type: Integer, desc: 'Delivery Note ID'
#         end
#         delete ':id' do
#           delivery_note = DeliveryNote.find(params[:id])
#           delivery_note.destroy!
#           { message: 'Delivery note deleted successfully' }
#         end
#       end
#     end
#   end
# end
