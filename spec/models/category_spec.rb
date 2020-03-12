# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should_not allow_value('Thisisalongcateegoryname').for(:name) }
  end

  context 'Associations' do
    it { should have_many(:articles).dependent(:destroy) }
  end
end