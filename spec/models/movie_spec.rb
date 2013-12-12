require 'spec_helper'

describe Movie do
  let(:movie) {Movie.new}

  describe "#snippet" do
    context "when description is less than or equal to 50 chars" do
      it "returns the full description" do
        allow(movie).to receive(:description).and_return("Hey there I'm less than 50")

        expect(movie.snippet).to eq("Hey there I'm less than 50")
      end
    end

    context "when the description is greater than 50 chars" do
      it 'returns the first 47 chars followed by elipses' do
        allow(movie).to receive(:description).and_return("This is a description that is clearly longer than 50.")

        expect(movie.snippet).to eq "This is a description that is clearly longer th..."
      end
    end

    context "when there is no description" do
      it 'returns an empty string' do
        allow(movie).to receive(:description).and_return()

        expect(movie.snippet).to eq ""
      end
    end
  end

  describe '#rotten_finder' do
    let(:rotten_finder_return) { OpenStruct.new(ratings: OpenStruct.new(audience_score: 84)) }
    context "when Movie is found on Rotten Tomatoes" do
      it "returns the audience score for the Movie" do
        allow(movie).to receive(:rotten_finder).and_return(rotten_finder_return)

        expect(rotten_finder_return.ratings.audience_scoregg).to eq(84)
      end   
    end
  end

  describe '.average_rating' do
    let(:movie2) { Movie.new}

    context "when all movies can be found on Rotten Tomatoes" do
      it "returns the average audience_score for all movies" do
        allow(movie2).to receive(:audience_score).and_return(50)
        allow(movie).to receive(:audience_score).and_return(100)
        
        expect(Movie.all.average_rating).to eq 75
      end 
    end

    context "when some movies are not found on Rotten Tomatoes" do
      it "returns the average audience_score of the movies that were found"
    end

    context "when no movies are found on Rotten Tomatoes" do
      it "returns nil"
    end
  end

end
