class Article < ApplicationRecord
  # include PgSearch
# pg_search_scope :search_by_full_name, against: [:title, :description]

  def self.search(search)
    if search
      where("LOWER(description) LIKE :search OR LOWER(title) LIKE :search OR LOWER(author) LIKE :search", search:"%#{search.downcase}%")
    else
      all
    end
  end
end
