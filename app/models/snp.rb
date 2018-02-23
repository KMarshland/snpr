# == Schema Information
#
# Table name: snps
#
#  id               :integer          not null, primary key
#  rsid             :string
#  chromosome       :string
#  position         :integer
#  allele1          :string
#  allele2          :string
#  checked_gwas     :boolean
#  functional_class :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_snps_on_checked_gwas  (checked_gwas)
#  index_snps_on_rsid          (rsid) UNIQUE
#

require Rails.root.join('lib', 'gwas', 'gwas.rb')

class Snp < ApplicationRecord

  has_many :genomic_contexts, dependent: :destroy
  has_and_belongs_to_many :sources

  validates :rsid, presence: true

  def pull_gwas

    client = GWAS::Client.new

    gwas_snp = client.find_snp self.rsid

    return self.update(checked_gwas: true) if gwas_snp.blank?

    # repull each time; don't double create
    self.genomic_contexts.destroy_all

    chromosome = self.chromosome
    position = self.position

    gwas_snp['genomicContexts'].each do |context|
      GenomicContext.create(
                        snp_id: self.id,
                        gene: context['gene']['geneName'],
                        distance: context['distance']
      )

      if context['isClosestGene']
        chromosome = context['location']['chromosomeName'] if chromosome.blank?
        position = context['location']['chromosomePosition'] if position.blank?
      end
    end

    self.update(
        checked_gwas: true,
        functional_class: gwas_snp['functionalClass'],
        chromosome: chromosome,
        position: position
    )
  end

end
