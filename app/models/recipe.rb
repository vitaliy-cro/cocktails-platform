class Recipe < ApplicationRecord

  self.inheritance_column = nil

  include Imagable

  has_attached_file :image, styles: { thumb: "64x64>" }, default_url: "missings/recipe.png"
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :name, :glass_id, :category_id, :type, presence: true, length: { maximum: 100 }

  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :reviews
  
  belongs_to :chef, counter_cache: true
  belongs_to :category, counter_cache: true
  belongs_to :glass, counter_cache: true

  paginates_per 5
end
