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

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    name_changed?
  end
end
