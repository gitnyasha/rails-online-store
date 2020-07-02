class Product < ApplicationRecord
  has_many :order_items
  belongs_to :category
  belongs_to :user
  mount_uploader :image, ImageUploader
  serialize :image, JSON
  def self.search(search)
    if search
      where(["name LIKE ?", "%#{search}%"])
    else
      all
    end
  end
end
