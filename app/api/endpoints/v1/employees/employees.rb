# frozen_string_literal: true

# module API
#   module V1
#     class Employees < Grape::API
#       # before { authenticate! }

#       resource :employees do
#         desc 'Get all employees'
#         get do
#           employees = Employee.includes(:user).all
#           present employees, with: EmployeeEntity::Base
#         end

#         desc 'Get a specific employee'
#         params do
#           requires :id, type: Integer, desc: 'Employee ID'
#         end
#         get ':id' do
#           employee = Employee.includes(:user).find(params[:id])
#           present employee, with: EmployeeEntity::Base
#         end

#         desc 'Create a new employee'
#         params do
#           requires :user_id, type: Integer, desc: 'User ID'
#           requires :matricule, type: String, desc: 'Employee matricule'
#           requires :department, type: String, desc: 'Department'
#           requires :position, type: String, desc: 'Position'
#           requires :status, type: String, desc: 'Status'
#           requires :salary, type: String, desc: 'Salary'
#         end
#         post do
#           employee = Employee.create!(declared(params))
#           present employee, with: EmployeeEntity::Base
#         end

#         desc 'Update an employee'
#         params do
#           requires :id, type: Integer, desc: 'Employee ID'
#           optional :department, type: String, desc: 'Department'
#           optional :position, type: String, desc: 'Position'
#           optional :status, type: String, desc: 'Status'
#           optional :salary, type: String, desc: 'Salary'
#         end
#         put ':id' do
#           employee = Employee.find(params[:id])
#           employee.update!(declared(params, include_missing: false))
#           present employee, with: EmployeeEntity::Base
#         end

#         desc 'Delete an employee'
#         params do
#           requires :id, type: Integer, desc: 'Employee ID'
#         end
#         delete ':id' do
#           employee = Employee.find(params[:id])
#           employee.destroy!
#           { message: 'Employee deleted successfully' }
#         end
#       end
#     end
#   end
# end
