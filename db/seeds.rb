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

loan_types = [
  {"SPECIAL LOAN" => "10% Interest rate. This loan is N2 million Maximum and is payable in 3 years"},
  {"HOUSING/MORTGAGE LOAN" => " 17% Interest rate. There is no limit. It is paid in two formats; the interest is monthly while the principal is paid every January"},
  {"COOPERATIVE/NORMAL LOAN" => "6.5% Interest rate. It is savings/contribution multiply by 2. Payable in 3 years"}
]

regular_user_info = [{ 
  :username => "NNPC/IB/01/7736",
  :email => "test-user@nnpcloanapp.com",
  :password => "p@ssword",
  :role_id =>"3",
  :profile_attributes => {
    :firstname => "Regular",
    :middlename => "",
    :lastname => "User",
    :gender => "",
    :phone => "+23399403922",
    :dob => "1980-12-13".to_date,
    :address1 => "SW/29928/3882",
    :address2 => "Ring road",
    :city => "Ibadan",
    :state => "Oyo",
    :nationality => "Nigerian",
    :designation => "Software Engineer",
    :department => "Information Technology",
    :location => "Ibadan",
    :year_of_employment => "2000-01-01".to_date.year
  }
}]

admin_user_info = [{ 
  :username => "admin-user",
  :email => "test-admin@nnpcloanapp.com",
  :password => "p@ssword",
  :role_id => "2",
  :profile_attributes => {
    :firstname => "Admin",
    :middlename => "",
    :lastname => "User",
    :gender => "",
    :phone => "+332992920039",
    :dob => "1978-12-13".to_date,
    :address1 => "SW/29928/3882",
    :address2 => "Felele road",
    :city => "Ibadan",
    :state => "Oyo",
    :nationality => "Nigerian",
    :designation => "Software Engineer",
    :department => "Information Technology",
    :location => "Ibadan",
    :year_of_employment => "1998-01-01".to_date.year
  }
}]

super_admin_user_info = [{ 
  :username => "super-admin-user",
  :email => "test-super-admin@nnpcloanapp.com",
  :password => "p@ssword",
  :role_id => "1",
  :profile_attributes => {
    :firstname => "Super Admin",
    :middlename => "",
    :lastname => "User",
    :gender => "",
    :phone => "+773666173288",
    :dob => "1968-11-12".to_date,
    :address1 => "SW/29928/3882",
    :address2 => "Dugbe, Mokola road",
    :city => "Ibadan",
    :state => "Oyo",
    :nationality => "Nigerian",
    :designation => "Software Engineer",
    :department => "Information Technology",
    :location => "Ibadan",
    :year_of_employment => "1985-01-01".to_date.year
  }
}]


roles.each do |role|
  role.each do |role_name, role_description|
    Role.find_or_create_by(name: role_name, description: role_description)
  end
end

loan_types.each do |loan_type|
  loan_type.each do |loan_type_name, loan_type_description|
    LoanType.find_or_create_by(name: loan_type_name, description: loan_type_description)
  end
end

regular_user = User.create(regular_user_info)

admin_user = User.create(admin_user_info)

super_admin_user = User.create(super_admin_user_info)