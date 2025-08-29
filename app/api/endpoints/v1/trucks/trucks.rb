# module API
#   module V1
#     class Trucks < Grape::API
#       # before { authenticate! }
      
#       resource :trucks do
#         desc 'Get all trucks'
#         get do
#           trucks = Truck.includes(:employee, :citerne).all
#           present trucks, with: TruckEntity::Base
#         end
        
#         desc 'Get a specific truck'
#         params do
#           requires :id, type: Integer, desc: 'Truck ID'
#         end
#         get ':id' do
#           truck = Truck.includes(:employee, :citerne).find(params[:id])
#           present truck, with: TruckEntity::Base
#         end
        
#         desc 'Create a new truck'
#         params do
#           requires :make, type: String, desc: 'Truck make'
#           requires :model, type: String, desc: 'Truck model'
#           requires :plate_number, type: String, desc: 'Plate number'
#           requires :status, type: String, desc: 'Status'
#           requires :vin, type: String, desc: 'VIN number'
#           requires :employee_id, type: Integer, desc: 'Employee ID'
#           requires :citerne_id, type: Integer, desc: 'Citerne ID'
#         end
#         post do
#           truck = Truck.create!(declared(params))
#           present truck, with: TruckEntity::Base
#         end
        
#         desc 'Update a truck'
#         params do
#           requires :id, type: Integer, desc: 'Truck ID'
#           optional :make, type: String, desc: 'Truck make'
#           optional :model, type: String, desc: 'Truck model'
#           optional :plate_number, type: String, desc: 'Plate number'
#           optional :status, type: String, desc: 'Status'
#           optional :vin, type: String, desc: 'VIN number'
#           optional :employee_id, type: Integer, desc: 'Employee ID'
#           optional :citerne_id, type: Integer, desc: 'Citerne ID'
#         end
#         put ':id' do
#           truck = Truck.find(params[:id])
#           truck.update!(declared(params, include_missing: false))
#           present truck, with: TruckEntity::Base
#         end
        
#         desc 'Delete a truck'
#         params do
#           requires :id, type: Integer, desc: 'Truck ID'
#         end
#         delete ':id' do
#           truck = Truck.find(params[:id])
#           truck.destroy!
#           { message: 'Truck deleted successfully' }
#         end
#       end
#     end
#   end
# end
