class Category < ApplicationRecord
  include FriendlySlugable

  acts_as_seo_carrier

  has_many :players, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :competitions, dependent: :destroy
  has_many :home_slides, inverse_of: :category, dependent: :destroy
  # has_many :info_blocks, as: :info_blockable, dependent: :destroy, inverse_of: :info_blockable
  # accepts_nested_attributes_for :info_blocks, reject_if: :all_blank, allow_destroy: true
  has_many :tabs, as: :tabable, dependent: :destroy, inverse_of: :tabable
  accepts_nested_attributes_for :tabs, reject_if: :all_blank, allow_destroy: true

  has_and_belongs_to_many :users_to_not_notify_by_email,
    class_name: 'User',
    join_table: 'users_categories_email_notifications',
    foreign_key: "category_id",
    association_foreign_key: "user_id"

  validates :description, presence: true,
                          length: { maximum: 50 }

  validates :sports, inclusion: { in: [true, false] }

  include PgSearch
  pg_search_scope :search_starts_with,
                  against: :description,
                  using: {tsearch: { prefix: true }}

  def title; description end

  private

  def prepare_slug
    super description
  end
end
