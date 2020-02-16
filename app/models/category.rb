class Category < ApplicationRecord
  before_save :downcase_category_name

  has_many :articles, dependent: :destroy

  validates :name, presence: true
  validates :priority, presence: true

  private

  def downcase_category_name
    self.name = name.downcase
  end
  
end
