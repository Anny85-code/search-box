class ApplicationController < ActionController::Base


def increment_counter(search)
      result = false
      puts "Nuri and Udo debugging"
      puts Querysearch.count
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
