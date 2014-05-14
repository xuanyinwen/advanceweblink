namespace :weblink do
  namespace :properties do

    desc "remove old properties from the database"
    task :purge_old => :environment do
      Property.old(Setting.first.max_property_age).find_each &:destroy
    end
  
  end
end
