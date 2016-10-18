class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
 class Movie::InvalidKeyError < StandardError ; end
  
  def self.find_in_tmdb(string)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    begin
      matching_movies=Tmdb::Movie.find(string)
    
      a_hashes = Array.new
        
      matching_movies.each do |movie|
        hashes = Hash.new
        releases = Tmdb::Movie.releases(movie.id)
        h_countries = releases["countries"]
        h_countries.each do |country|
          if country["iso_3166_1"] == "US" and country["certification"] !=""
            rating = country["certification"]
            hashes[:tmdb_id] = movie.id
            hashes[:title] = movie.title
            hashes[:rating] = rating
            hashes[:release_date] = movie.release_date
            
            a_hashes << hashes
          end
        end
      end
      a_hashes
    rescue Tmdb::InvalidApiKeyError
        raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end
  
  def create_from_tmdb(hash)
    
  end
end
