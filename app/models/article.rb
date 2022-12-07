class Article < ApplicationRecord

  def self.search(search)
    if search
      where("LOWER(description) LIKE :search OR LOWER(title) LIKE :search OR LOWER(author) LIKE :search", search:"%#{search.downcase}%")
    else
      all
    end
    
  end
end
