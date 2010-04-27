class Course < ActiveRecord::Base

  validates_presence_of :area, :subarea, :nivel

end
