class Bookmark < ActiveRecord::Base

  before_create :set_domain
  validates_presence_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_uniqueness_of :url, :scope => :user_id

  def set_domain
    if self.url.present?
      self.domain = self.url.split('://')[1].split('/')[0]
    end
  end

  def self.search(api_key,search_term)
    User.find_by_api_key(api_key).bookmarks.where("title like ?", "%#{search_term}%")
  end
end

