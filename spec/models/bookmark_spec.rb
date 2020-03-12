# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:article_id) }
  end

  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end
end