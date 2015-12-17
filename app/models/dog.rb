class Dog < ActiveRecord::Base
  belongs_to :owner, { class_name: "Person" }
  has_many :ratings, { :class_name => "Rating", :foreign_key => :dog_id }
end
