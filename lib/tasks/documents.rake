
namespace :documents do
  task :import => :environment do

    Document.where(imported: false).find_each do |document|
      document.import
    end

  end

end
