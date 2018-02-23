# == Schema Information
#
# Table name: sources
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sources_on_name  (name) UNIQUE
#

class Source < ApplicationRecord

  has_many :documents
  has_and_belongs_to_many :snps

  validates :name, presence: true, uniqueness: true

  def self.sources
    %i[
        23andme
        ancestry
        ftdna-illumina
    ]
  end

  validates :name, inclusion: { in: Source.sources.map(&:to_s),
                                  message: '%<value> is not a valid source' }

  def to_s
    self.name
  end

end
