# frozen_string_literal: true

# module API
#   module V1
#     class Citernes < Grape::API
#       # before { authenticate! }

#       resource :citernes do
#         desc 'Get all citernes'
#         get do
#           citernes = Citerne.all
#           present citernes, with: CiterneEntity::Base
#         end

#         desc 'Get a specific citerne'
#         params do
#           requires :id, type: Integer, desc: 'Citerne ID'
#         end
#         get ':id' do
#           citerne = Citerne.find(params[:id])
#           present citerne, with: CiterneEntity::Base
#         end

#         desc 'Create a new citerne'
#         params do
#           requires :plate_number, type: String, desc: 'Plate number'
#           requires :chassis_number, type: String, desc: 'Chassis number'
#           requires :capacity, type: String, desc: 'Capacity'
#           requires :status, type: String, desc: 'Status'
#         end
#         post do
#           citerne = Citerne.create!(declared(params))
#           present citerne, with: CiterneEntity::Base
#         end

#         desc 'Update a citerne'
#         params do
#           requires :id, type: Integer, desc: 'Citerne ID'
#           optional :plate_number, type: String, desc: 'Plate number'
#           optional :chassis_number, type: String, desc: 'Chassis number'
#           optional :capacity, type: String, desc: 'Capacity'
#           optional :status, type: String, desc: 'Status'
#         end
#         put ':id' do
#           citerne = Citerne.find(params[:id])
#           citerne.update!(declared(params, include_missing: false))
#           present citerne, with: CiterneEntity::Base
#         end

#         desc 'Delete a citerne'
#         params do
#           requires :id, type: Integer, desc: 'Citerne ID'
#         end
#         delete ':id' do
#           citerne = Citerne.find(params[:id])
#           citerne.destroy!
#           { message: 'Citerne deleted successfully' }
#         end
#       end
#     end
#   end
# end
