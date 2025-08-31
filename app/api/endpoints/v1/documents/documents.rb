# frozen_string_literal: true

# module API
#   module V1
#     class Documents < Grape::API
#       # before { authenticate! }

#       resource :documents do
#         desc 'Get all documents'
#         get do
#           documents = Document.includes(:employee, :truck, :citerne).all
#           present documents, with: DocumentEntity::Base
#         end

#         desc 'Get a specific document'
#         params do
#           requires :id, type: Integer, desc: 'Document ID'
#         end
#         get ':id' do
#           document = Document.includes(:employee, :truck, :citerne).find(params[:id])
#           present document, with: DocumentEntity::Base
#         end

#         desc 'Create a new document'
#         params do
#           requires :title, type: String, desc: 'Document title'
#           requires :type, type: String, desc: 'Document type'
#           requires :status, type: String, desc: 'Document status'
#           optional :description, type: String, desc: 'Document description'
#           optional :file_path, type: String, desc: 'File path'
#           optional :number, type: String, desc: 'Document number'
#           optional :delivery_date, type: Date, desc: 'Delivery date'
#           optional :expiry_date, type: Date, desc: 'Expiry date'
#           optional :employee_id, type: Integer, desc: 'Employee ID'
#           optional :truck_id, type: Integer, desc: 'Truck ID'
#           optional :citerne_id, type: Integer, desc: 'Citerne ID'
#         end
#         post do
#           document = Document.create!(declared(params))
#           present document, with: DocumentEntity::Base
#         end

#         desc 'Update a document'
#         params do
#           requires :id, type: Integer, desc: 'Document ID'
#           optional :title, type: String, desc: 'Document title'
#           optional :type, type: String, desc: 'Document type'
#           optional :status, type: String, desc: 'Document status'
#           optional :description, type: String, desc: 'Document description'
#           optional :file_path, type: String, desc: 'File path'
#           optional :number, type: String, desc: 'Document number'
#           optional :delivery_date, type: Date, desc: 'Delivery date'
#           optional :expiry_date, type: Date, desc: 'Expiry date'
#           optional :employee_id, type: Integer, desc: 'Employee ID'
#           optional :truck_id, type: Integer, desc: 'Truck ID'
#           optional :citerne_id, type: Integer, desc: 'Citerne ID'
#         end
#         put ':id' do
#           document = Document.find(params[:id])
#           document.update!(declared(params, include_missing: false))
#           present document, with: DocumentEntity::Base
#         end

#         desc 'Delete a document'
#         params do
#           requires :id, type: Integer, desc: 'Document ID'
#         end
#         delete ':id' do
#           document = Document.find(params[:id])
#           document.destroy!
#           { message: 'Document deleted successfully' }
#         end
#       end
#     end
#   end
# end
