class Movie < ActiveRecord::Base
  has_many :showtimes
  has_many :roles
  has_many :stars, through: :roles

  validates :title, presence: true

  def rotten_finder
    RottenMovie.find(title: title, limit: 1)
  end
  
  def snippet
    description.to_s.truncate 50
  end

  def average_rating
    scores = []
    movies = Movie.all
    movies.each do |movie|
      scores << movie.ratings.audience_score
    end
    scores.reduce(:+)
  end

end

