class Cat < ActiveRecord::Base
  has_many :ratings, { :class_name => "Rating", :foreign_key => :cat_id }
end
