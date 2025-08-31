# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoints::V1::Users::List, type: :request do
  subject(:do_request) { get '/api/v1/users', headers: headers }

  let(:headers) do
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'Host' => 'localhost'
    }
  end

  let(:users) { create_list(:user, 3) }

  before do
    User.delete_all
    users
  end

  describe 'GET /api/v1/users' do
    context 'when the request is successful' do
      let(:expected_response) do
        {
          'items' => users.map do |user|
            {
              'id' => user.id,
              'first_name' => user.first_name,
              'last_name' => user.last_name,
              'email' => user.email,
              'phone_number' => user.phone_number,
              'role' => user.role,
              'is_active' => user.is_active,
              'address_line' => user.address_line,
              'city' => user.city,
              'state' => user.state,
              'country' => user.country
            }
          end
        }
      end

      it 'returns a success response' do
        do_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct number of users' do
        do_request

        expect(json_response['items'].count).to eq(users.count)
      end

      it 'returns the correct response' do
        do_request
        expect(json_response).to eq(expected_response)
      end
    end
  end
end
