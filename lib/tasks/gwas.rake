
namespace :gwas do

  task :import => :environment do

    imported = 0
    start_time = DateTime.now

    Snp.where(checked_gwas: false).find_each do |snp|
      snp.pull_gwas

      STDOUT << '.'

      imported += 1

      if imported % 100 == 0
        time_elapsed = ((DateTime.now - start_time).to_f * 1.day).round(2)

        puts " #{imported} imported (#{time_elapsed}s elapsed)"
      end
    end

  end

  task :test => :environment do

    require Rails.root.join('lib', 'gwas', 'gwas.rb')

    client = GWAS::Client.new

    puts client.find_snp('rs7329174').class.inspect

  end

end
