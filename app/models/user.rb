class User < ActiveRecord::Base
  has_many :subscriptions
end
