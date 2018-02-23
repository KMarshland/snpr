
namespace :gwas do

  task :test => :environment do

    require Rails.root.join('lib', 'gwas', 'gwas.rb')

    client = GWAS::Client.new

    puts client.find_snp('rs7329174').class.inspect

  end

end
