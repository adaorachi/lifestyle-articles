# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
  end

  context 'Associations' do
    it { should have_many(:articles) }
    it { should have_many(:articles).with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:voted_articles).through(:votes) }
    it { should have_many(:bookmarked_articles).through(:bookmarks) }
  end
end