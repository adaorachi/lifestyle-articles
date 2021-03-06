# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe Article, type: :model do
  
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:featured_image) }
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:category_id) }
    it { should_not allow_value('it').for(:title) }
    it { should_not allow_value('This is my post').for(:text) }
  end

  context 'Associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:category) }
    it { should have_many(:comments).with_foreign_key('article_id').dependent(:destroy) }
    it { should have_many(:votes) }
    it { should have_many(:voters).through(:votes) }
    it { should have_many(:bookmarks) }
    it { should have_many(:bookmarked_readers).through(:bookmarks) }
    it { should have_many(:taggings) }
    it { should have_many(:tags).through(:taggings) }
  end

  context 'Scopes' do
    it "applies a default scope to descending order of articles" do
      expect(Article.all.to_sql).to eq Article.all.order(created_at: :desc).to_sql
    end

  end

 
end