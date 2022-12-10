class ApplicationController < ActionController::Base


def increment_counter(search)
  if search != nil
    result = false
      Querysearch.all.each do |query|
        if query.keywords.include?(search.downcase)
          temp = query.count + 1
          query.count = temp
          query.save
          result = true
        end
      
      end
    
        if result == false
          Querysearch.create(keywords: search.downcase, count: 1)
        end
      end
  end
      
    

    def most_frequent_item_count
      Querysearch.maximum(:keywords)
    end
end