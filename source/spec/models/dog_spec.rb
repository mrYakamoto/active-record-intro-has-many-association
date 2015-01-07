require_relative '../spec_helper'

describe "Dog" do
  describe "inheritance" do
    it "inherits from ActiveRecord::Base" do
      expect(Dog < ActiveRecord::Base).to be true
    end
  end

  describe "associations" do

    before(:all) do
      Person.delete_all
      Person.create([
        {first_name: "Teagan",  last_name: "Hickman"},
        {first_name: "Taylor",  last_name: "Long-Hurst"}
      ])

      teagan = Person.find_by(first_name: "Teagan")
      taylor = Person.find_by(first_name: "Taylor")

      Dog.delete_all
      tenley = Dog.create( { :name     => "Tenley",
                             :license  => "OH-9384764",
                             :age      => 1,
                             :breed    => "Golden Doodle",
                             :owner_id => teagan.id } )

      Rating.delete_all
      Rating.create([
        { coolness: 8, cuteness: 10, dog_id: tenley.id, judge_id: teagan.id },
        { coolness: 8, cuteness: 10, dog_id: tenley.id, judge_id: taylor.id }
      ])
    end

    describe "has many ratings" do
      describe "#ratings" do
        it "returns the dog's ratings" do
          dog = Dog.first
          expected_ratings = Rating.where(dog_id: dog.id)

          expect(dog.ratings).to eq expected_ratings
        end

        it "returns a collection of Rating objects" do
          dog = Dog.first
          ratings = dog.ratings

          expect(ratings.all? { |rating| rating.instance_of? Rating }).to be true
        end
      end

      describe "#ratings=" do
        it "reassigns the dog's ratings" do
          dog = Dog.first
          expect{ dog.ratings = [] }.to change{ dog.ratings.empty? }.from(false).to(true)
        end
      end
    end

    describe "belongs to owner" do
      describe "#owner" do
        it "returns the dog's owner" do
          dog = Dog.first
          expected_owner = Person.find(dog.owner_id)

          expect(dog.owner).to eq expected_owner
        end

        it "returns a Person object" do
          dog = Dog.first
          expect(dog.owner).to be_instance_of Person
        end
      end

      describe "#owner=" do
        it "sets owner_id" do
          dog = Dog.new
          new_owner = Person.first

          expect{ dog.owner = new_owner }.to change{ dog.owner_id }.from(nil).to(new_owner.id)
        end
      end
    end
  end
end
