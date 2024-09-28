class Backlink < ApplicationRecord
	validates :site, :country, :category, :price, :domain_rank, :added_on, :duration, presence: true
end
