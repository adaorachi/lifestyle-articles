# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tagging, type: :model do

  context 'Associations' do
    it { should belong_to(:tag) }
    it { should belong_to(:article) }
  end
end