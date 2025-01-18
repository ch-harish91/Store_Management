# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Role.find_or_create_by(name: 'system_admin', description: 'Has full access to the system')
Role.find_or_create_by(name: 'normal_user', description: 'Can browse and use basic features')
Role.find_or_create_by(name: 'store_owner', description: 'Can manage their own store')

# User.find_or_create_by(name: "system_admin", email: "system_admin@gmail.com")

