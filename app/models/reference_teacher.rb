class ReferenceTeacher < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :user
end
