class QueryController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Returns a list of suggestions based on most frequent queries in real time
  def suggestions
    @queries = Query.suggest_most_frequent(params[:query].downcase).limit(5)
  end

  # Save a search query incrementing the counter if exists
  def search
    @query = Query.where(text: params[:query].downcase).first_or_initialize
    if query.save
      broadcast_queries
      return @query
    end
  end

  # Returns all queries order by most frequent
  def all_searches
    @queries = Query.all.most_frequent
  end

  # Resets the count attribute of all queries
  def reset_queries
    if Query.update_all(count: 0)
      broadcast_queries
    end
    
  end

  # Broadcasts most frequent queries through websocket
  def broadcast_queries
    WebsocketRails[:query].trigger 'all_searches', Query.all.most_frequent
  end
end
