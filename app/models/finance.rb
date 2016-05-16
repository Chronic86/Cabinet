class Finance < ActiveRecord::Base

	belongs_to :locality
	belongs_to :company
	belongs_to :period
end
