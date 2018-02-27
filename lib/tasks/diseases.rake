
namespace :diseases do

  task :fetch => :environment do
    Disease.pull_from_gwas
  end

end