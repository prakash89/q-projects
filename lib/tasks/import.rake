require 'csv'

RAILS_ENV = ENV["RAILS_ENV"] || "development"

namespace 'import' do

  desc "Import Link Types"
  task 'link_types' => :environment do

    if ["true", "t","1","yes","y"].include?(ENV["truncate_all"].to_s.downcase.strip)
      Image::Base.where("imageable_type = 'LinkType'").destroy_all
      LinkType.destroy_all
      ProjectLink.destroy_all
    end

    path = "db/import_data/#{RAILS_ENV}/link_types.csv"
    csv_table = CSV.table(path, {headers: true, converters: nil, header_converters: :symbol})
    headers = csv_table.headers
    csv_table.each do |row|

      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }

      next if row[:name].blank?

      link_type = LinkType.find_by_name(row[:title]) || LinkType.new
      link_type.name = row[:name]
      link_type.description = row[:description]
      link_type.theme = row[:theme]
      link_type.button_text = row[:button_text]

      # Adding a client picture
      picture = nil
      image_name = row[:image_name]
      unless image_name.strip.blank?
        image_path = "db/import_data/#{RAILS_ENV}/images/link_types/#{image_name}"
        if File.exists?(image_path)
          picture = link_type.build_picture
          picture.image = File.open(image_path)
        end
      end

      if link_type.valid? && (picture.blank? || picture.valid?)
        puts "#{link_type.name} saved".green if link_type.save!
      else
        puts "Error! #{link_type.errors.full_messages.to_sentence}".red
      end

    end
  end

  desc "Import Clients"
  task 'clients' => :environment do

    if ["true", "t","1","yes","y"].include?(ENV["truncate_all"].to_s.downcase.strip)
      Image::Base.where("imageable_type = 'Client'").destroy_all
      Client.destroy_all
    end

    path = "db/import_data/#{RAILS_ENV}/clients.csv"
    csv_table = CSV.table(path, {headers: true, converters: nil, header_converters: :symbol})
    headers = csv_table.headers
    csv_table.each do |row|

      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }

      next if row[:name].blank?

      client = Client.find_by_name(row[:name]) || Client.new
      client.name = row[:name]
      client.description = row[:description]
      client.city = row[:city]
      client.state = row[:state]
      client.country = row[:country]
      client.pretty_url = row[:pretty_url]

      # Adding a client picture
      logo = nil
      image_name = row[:image_name]
      unless image_name.strip.blank?
        image_path = "db/import_data/#{RAILS_ENV}/images/clients/#{image_name}"
        if File.exists?(image_path)
          logo = client.build_logo
          logo.image = File.open(image_path)
        end
      end

      if client.valid? && (logo.blank? || logo.valid?)
        puts "#{client.name} saved".green if client.save!
      else
        puts "Error! #{client.errors.full_messages.to_sentence}".red
      end

    end
  end

  desc "Import Projects"
  task 'projects' => :environment do

    if ["true", "t","1","yes","y"].include?(ENV["truncate_all"].to_s.downcase.strip)
      Image::Base.where("imageable_type = 'Project'").destroy_all
      Project.destroy_all
    end

    path = "db/import_data/#{RAILS_ENV}/projects.csv"
    csv_table = CSV.table(path, {headers: true, converters: nil, header_converters: :symbol})
    headers = csv_table.headers
    csv_table.each do |row|
      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }

      next if row[:name].blank?

      project = Project.find_by_name(row[:name]) || Project.new
      project.name = row[:name]
      project.description = row[:description]
      project.pretty_url = row[:pretty_url]

      if row[:client]
        project.client = Client.find_by_name(row[:client])
      elsif RAILS_ENV == "development"
        project.client = Client.rand()
      else
        puts "Skipping: Client with username '#{row[:client]}' not found ".orange
        next
      end

      ## Adding a profile picture
      image_name = row[:image_name]
      logo = nil
      unless image_name.strip.blank?
        image_path = "db/import_data/#{RAILS_ENV}/images/projects/#{image_name}"
        if File.exists?(image_path)
          logo = project.build_logo
          logo.image = File.open(image_path)
        end
      end

      if project.valid? && (logo.blank? || logo.valid?)
        puts "#{project.name} saved".green if project.save!
      else
        puts "Error! #{project.errors.full_messages.to_sentence}".red
      end

    end
  end

  desc "Import Users"
  task 'users' => :environment do

    if ["true", "t","1","yes","y"].include?(ENV["truncate_all"].to_s.downcase.strip)
      Image::Base.where("imageable_type = 'User'").destroy_all
      Role.destroy_all
      User.destroy_all
    end

    path = "db/import_data/#{RAILS_ENV}/users.csv"
    csv_table = CSV.table(path, {headers: true, converters: nil, header_converters: :symbol, col_sep: "\t"})
    headers = csv_table.headers

    csv_table.each do |row|

      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }

      next if row[:name].blank?

      user = User.find_by_username(row[:username]) || User.new
      user.name = row[:name]
      user.username = row[:username]
      user.email = row[:email]
      user.phone = row[:phone]
      user.designation = row[:designation]
      user.department = row[:department]
      user.city = row[:city]
      user.state = row[:state]
      user.country = row[:country]

      if user.valid?
        user.save
        puts "#{row[:username]} saved".green
      else
        puts "#{row[:username]} was not saved".red
      end

    end
  end

  desc "Import Roles"
  task 'roles' => :environment do

    if ["true", "t","1","yes","y"].include?(ENV["truncate_all"].to_s.downcase.strip)
      Role.destroy_all
    end

    path = "db/import_data/#{RAILS_ENV}/roles.csv"
    csv_table = CSV.table(path, {headers: true, converters: nil, header_converters: :symbol})
    headers = csv_table.headers

    csv_table.each do |row|

      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }

      next if row[:project].blank? || row[:username].blank? || row[:role].blank?

      user = User.find_by_username(row[:username])
      project = Project.find_by_name(row[:project])

      unless ConfigCenter::Roles::LIST.include?(row[:role])
        puts "Skipping: role not found '#{row[:role]}' ".red
        next
      end

      unless user
        puts "Skipping: user not found '#{row[:username]}' ".red
        next
      end

      unless project
        puts "Skipping: project not found '#{row[:project]}' ".red
        next
      end

      role = row[:role]
      user.add_role role, project
      puts "Gave access to '#{user.name} for project '#{project.name}' ".green

    end
  end

  desc "Import Project Links"
  task 'project_links' => :environment do

    if ["true", "t","1","yes","y"].include?(ENV["truncate_all"].to_s.downcase.strip)
      ProjectLink.destroy_all
    end

    path = "db/import_data/#{RAILS_ENV}/project_links.csv"
    csv_table = CSV.table(path, {headers: true, converters: nil, header_converters: :symbol})
    headers = csv_table.headers

    csv_table.each do |row|

      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }

      if row[:project].blank? || row[:link_type].blank? || row[:url].blank?
        #puts "Skipping: input not sufficient ".red
        next
      end

      link_type = LinkType.find_by_name(row[:link_type])
      project = Project.find_by_name(row[:project])

      unless link_type
        puts "Skipping: link_type not found '#{row[:link_type]}' ".red
        next
      end

      unless project
        puts "Skipping: project not found '#{row[:project]}' ".red
        next
      end

      project_link = ProjectLink.new
      project_link.project = project
      project_link.link_type = link_type
      project_link.url = row[:url]

      if project_link.valid?
        puts "linked #{project_link.project.name} with #{project_link.link_type.name}".green if project_link.save!
      else
        puts "Error! #{project_link.errors.full_messages.to_sentence}".red
      end

    end
  end

  desc "Import all data in sequence"
  task 'all' => :environment do

    import_list = ["link_types", "clients", "projects", "users", "roles", "project_links"]

    import_list.each do |item|
      puts "Importing #{item.titleize}".yellow
      begin
        Rake::Task["import:#{item}"].invoke
      rescue Exception => e
        puts "Importing #{item.titleize} - Failed - #{e.message}".red
      end
    end

  end

end