class CarUser < ApplicationRecord
  belongs_to :user
  belongs_to :car

end
