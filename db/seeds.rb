# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = [
  {"Super Administrator" => "The super admin has unlimited access to the application"},
  {"Administrator" => "This is the application manager, it is the next to the super administrator"},
  {"Regular User" => "This is the regular user of the application, it has limited access"}
]

roles.each do |role|
  role.each do |role_name, role_description|
    Role.find_or_create_by(name: role_name, description: role_description)
  end
end