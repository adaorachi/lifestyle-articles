# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do

  context 'Associations' do
    it { should have_many(:taggings).dependent(:destroy) }
    it { should have_many(:articles).through(:taggings) }
  end
end