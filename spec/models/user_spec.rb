# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }

  describe 'associations' do
    it { is_expected.to have_one(:employee).dependent(:destroy) }
  end

  describe 'validations' do
    %i(first_name last_name email phone_number address_line city state country).each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  describe 'uniqueness' do
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe '#full_name' do
    it { is_expected.to respond_to(:full_name) }

    it 'returns the full name of the user' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
