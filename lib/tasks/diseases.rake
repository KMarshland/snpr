
namespace :diseases do

  task :pull_snps => :environment do
    Disease.where(checked_gwas: false).find_each do |disease|
      disease.pull_snps
    end
  end

  task :fetch => :environment do
    Disease.pull_from_gwas
  end

end