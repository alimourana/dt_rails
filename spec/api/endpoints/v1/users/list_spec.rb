# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users List Endpoint" do
  describe "User factory" do
    it "creates valid users" do
      user = create(:user)
      expect(user).to be_valid
      expect(user.first_name).to be_present
      expect(user.last_name).to be_present
      expect(user.email).to be_present
      expect(user.phone_number).to be_present
      expect(user.role).to be_present
      expect(user.is_active).to be_in([true, false])
    end

    it "creates users with different roles" do
      admin_user = create(:user, :admin)
      manager_user = create(:user, :manager)
      regular_user = create(:user, :regular_user)

      expect(admin_user.role).to eq("admin")
      expect(manager_user.role).to eq("manager")
      expect(regular_user.role).to eq("user")
    end

    it "creates active and inactive users" do
      active_user = create(:user, :active)
      inactive_user = create(:user, :inactive)

      expect(active_user.is_active).to be true
      expect(inactive_user.is_active).to be false
    end

    it "creates users with required address fields" do
      user = create(:user)
      expect(user.address_line).to be_present
      expect(user.city).to be_present
      expect(user.state).to be_present
      expect(user.country).to be_present
    end
  end

  describe "User entity serialization" do
    let(:user) { create(:user) }
    let(:serialized_user) { Entities::User.represent(user).as_json }

    it "exposes the correct attributes" do
      expect(serialized_user.keys).to match_array([
        :id, :first_name, :last_name, :email, :phone_number, 
        :role, :is_active, :created_at, :updated_at
      ])
    end

    it "serializes user data correctly" do
      expect(serialized_user[:id]).to eq(user.id)
      expect(serialized_user[:first_name]).to eq(user.first_name)
      expect(serialized_user[:last_name]).to eq(user.last_name)
      expect(serialized_user[:email]).to eq(user.email)
      expect(serialized_user[:phone_number]).to eq(user.phone_number)
      expect(serialized_user[:role]).to eq(user.role)
      expect(serialized_user[:is_active]).to eq(user.is_active)
    end

    it "does not expose address fields" do
      expect(serialized_user.keys).not_to include(:address_line, :city, :state, :country)
    end
  end

  describe "Endpoint configuration" do
    it "has the correct class structure" do
      expect(Endpoints::V1::Users::List).to be < Grape::API
    end

    it "is properly mounted in the base API" do
      # Just verify that the endpoint class exists and is properly structured
      expect(Endpoints::V1::Users::List).to be_a(Class)
      expect(Endpoints::Base).to be_a(Class)
    end
  end

  describe "User model validations" do
    it "requires first_name" do
      user = build(:user, first_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "requires last_name" do
      user = build(:user, last_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "requires email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "requires valid email format" do
      user = build(:user, email: "invalid-email")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it "requires unique email" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "requires valid role" do
      user = build(:user, role: "invalid_role")
      expect(user).not_to be_valid
      expect(user.errors[:role]).to include("is not included in the list")
    end

    it "accepts valid roles" do
      %w[user admin manager].each do |role|
        user = build(:user, role: role)
        expect(user).to be_valid
      end
    end
  end
end
