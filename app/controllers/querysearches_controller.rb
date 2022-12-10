class QuerysearchController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @queries = Querysearch.all
  end

  
  def show 
    if Querysearch.update_all(count: 0)
      broadcast_queries
    end
  end

  # Save a search query incrementing the counter if exists
  # def search
  #   @query = Querysearch.where(text: params[:querysearch].downcase).first_or_initialize
  #   if query.save
  #     broadcast_queries
  #     return @query
  #   end
  # end

  # Returns all queries order by most frequent
  def all_searches
    @queries = Querysearch.all.most_frequent
  end

  # Resets the count attribute of all queries
  def reset_queries
    if Querysearch.update_all(count: 0)
      broadcast_queries
    end
    
  end

  # Broadcasts most frequent queries through websocket
  def broadcast_queries
    WebsocketRails[:query].trigger 'all_searches', Querysearch.all.most_frequent
  end
end
