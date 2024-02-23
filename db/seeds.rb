# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create users with avatars
users_with_avatars = [
  { username: 'user1', email: 'user1@test.com', password: 'password1' },
  { username: 'user2', email: 'user2@test.com', password: 'password2' },
  # Add more users as needed
]

# Image filenames
avatar_filenames = ['pic1.jpg', 'pic2.jpg']

# Iterate over users and attach avatars
users_with_avatars.each_with_index do |user_attributes, index|
  user = User.create!(user_attributes)

  # Attach avatar to each user
  avatar_filename = avatar_filenames[index]
  avatar_path = Rails.root.join('assets', 'images', avatar_filename)

  begin
    user.avatar_img.attach(io: File.open(avatar_path), filename: avatar_filename, content_type: 'image/jpeg')
    puts "User '#{user.username}' created with avatar '#{avatar_filename}'."
  rescue Errno::ENOENT
    puts "Error: Avatar file '#{avatar_filename}' not found."
  rescue StandardError => e
    puts "Error attaching avatar to user '#{user.username}': #{e.message}"
  end
end

puts "Seeding complete."