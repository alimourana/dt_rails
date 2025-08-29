# module API
#   module V1
#     module Endpoints
#       module BillingRates
#         class Index < Grape::API
#           extend Grape::API::Helpers
          
#           resource :billing_rates do
#             namespace_setting(:category, "billing_rates")
            
#             desc 'Get all billing rates', {
#               summary: 'Get all billing rates',
#               detail: 'Get all billing rates',
#               success: BillingRateEntity::Base,
#               failure: [
#                 { code: 400, message: 'Bad Request' },
#                 { code: 401, message: 'Unauthorized' },
#                 { code: 404, message: 'Not Found' },
#                 { code: 500, message: 'Internal Server Error' }
#               ]
#             }
#             endpoint "getBillingRates"
#             get do
#               billing_rates = BillingRate.all
#               present billing_rates, with: BillingRateEntity::Base
#             end
#           end
#         end
#       end
#     end
#   end
# end

#       resource :billing_rates do  
#         desc 'Get all billing rates', {
#           summary: 'Get all billing rates',
#           detail: 'Get all billing rates',
#           success: BillingRateEntity::Base,
#           failure: [
#             { code: 400, message: 'Bad Request' },
#             { code: 401, message: 'Unauthorized' },
#             { code: 404, message: 'Not Found' },
#             { code: 500, message: 'Internal Server Error' }
#           ]
#         }
#         endpoint "getBillingRates"
#         get do
#           billing_rates = BillingRate.all
#           present billing_rates, with: BillingRateEntity::Base
#         end
#       end

#       resource :billing_rates do  
#         desc 'Get all billing rates', {
#           summary: 'Get all billing rates',
#           detail: 'Get all billing rates',
#           success: BillingRateEntity::Base,
#           failure: [
#             { code: 400, message: 'Bad Request' },
#             { code: 401, message: 'Unauthorized' },
#             { code: 404, message: 'Not Found' },
#             { code: 500, message: 'Internal Server Error' }
#           ]
#         } 
#         endpoint "getBillingRates"
#         get do
#             billing_rates = BillingRate.all
#             present billing_rates, with: BillingRateEntity::Base
#         end
#       end


#       resource :billing_rates do  
#         desc 'Get a specific billing rate', {
#           summary: 'Get a specific billing rate',
#           detail: 'Get a specific billing rate with the given ID',
#           success: BillingRateEntity::Base,
#           failure: [
#             { code: 400, message: 'Bad Request' },
#             { code: 401, message: 'Unauthorized' },
#             { code: 404, message: 'Not Found' },
#             { code: 500, message: 'Internal Server Error' }
#           ]
#         }
#         endpoint "getBillingRate"
#         params do
#           requires :id, type: Integer, desc: 'Billing Rate ID'
#         end
#         get ':id' do
#           billing_rate = BillingRate.find(params[:id])
#           present billing_rate, with: BillingRateEntity::Base
#         end
#       end

#       resource :billing_rates do  
#         desc 'Create a new billing rate', {
#           summary: 'Create a new billing rate',
#           detail: 'Create a new billing rate with the given parameters',
#           success: BillingRateEntity::Base,
#           failure: [
#             { code: 400, message: 'Bad Request' },
#             { code: 401, message: 'Unauthorized' },
#             { code: 404, message: 'Not Found' },
#             { code: 500, message: 'Internal Server Error' }
#           ]
#         }
#         endpoint "createBillingRate"
#         params do
#           requires :id, type: Integer, desc: 'Billing Rate ID'
#           optional :origin, type: String, desc: 'Origin'
#           optional :destination, type: String, desc: 'Destination'
#           optional :rate, type: BigDecimal, desc: 'Rate'
#         end
#         put ':id' do
#           billing_rate = BillingRate.find(params[:id])
#           billing_rate.update!(declared(params, include_missing: false))
#           present billing_rate, with: BillingRateEntity::Base
#         end
#         post do
#            billing_rate = BillingRate.create!(declared(params))
#           present billing_rate, with: BillingRateEntity::Base
#         }
#         endpoint "updateBillingRate"
#         params do
#           requires :id, type: Integer, desc: 'Billing Rate ID'
#           optional :origin, type: String, desc: 'Origin'
#           optional :destination, type: String, desc: 'Destination'
#           optional :rate, type: BigDecimal, desc: 'Rate'
#         end
#         put ':id' do
#           billing_rate = BillingRate.find(params[:id])
#           billing_rate.update!(declared(params, include_missing: false))
#           present billing_rate, with: BillingRateEntity::Base
#         end
#       end