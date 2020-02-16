# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:featured_image) }
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:category_id) }
  end

  context 'Associations' do
    it { should have_many(:comments).with_foreign_key('article_id').dependent(:destroy) }
    it { should have_many(:voters).through(:votes) }
    it { should have_many(:bookmarked_readers).through(:bookmarks) }
  end
end