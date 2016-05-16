class Locality < ActiveRecord::Base

	has_many :finances
	has_many :people
end
