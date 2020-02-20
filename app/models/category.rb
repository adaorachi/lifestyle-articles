class Category < ApplicationRecord
  before_save :downcase_category_name

  has_many :articles, dependent: :destroy

  validates :name, presence: true, length: { in: 3..8 }

  def name_with_caps
    self.name.capitalize
  end

  private

  def downcase_category_name
    self.name = name.downcase
  end
  
end
