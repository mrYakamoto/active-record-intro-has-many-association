class Person < ActiveRecord::Base
has_many :dogs, { :class_name => "Dog", :foreign_key => :owner_id }
has_many :ratings, { :class_name => "Rating", :foreign_key => :judge_id }
end
