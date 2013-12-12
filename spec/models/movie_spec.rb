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

  describe '#audience_rating' do
    let(:rotten_finder_return) { OpenStruct.new(ratings: OpenStruct.new(audience_score: 84)) }
    context "when Movie is found on Rotten Tomatoes" do
      it "returns the audience score for the Movie" do
        allow(movie).to receive(:rotten_finder).and_return(rotten_finder_return)

        expect(movie.audience_rating).to eq(84)
      end   
    end
  end
end
