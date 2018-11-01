class User < ApplicationRecord
  has_secure_password
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile

  def self.to_csv(options={})
    attributes = %w{ 
      id 
      username 
      email
    }
    profile_attributes = %w{
      firstname
      middlename
      lastname
      phone
      dob
      address1
      address2
      city
      state
      nationality
      designation
      department
      location
      year_of_employment
    }
    ::CSV.generate(options) do |csv|
      csv << attributes + profile_attributes
      all.each do |user|
        values = user.attributes.slice(*attributes).values
        if user.profile
          values += user.profile.attributes.slice(*profile_attributes).values
        end
        csv << values
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      User.create! row.to_hash
    end
  end
end
