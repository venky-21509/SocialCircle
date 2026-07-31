# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
puts "Destroying existing data..."
User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Follow.destroy_all

# Create sample users
puts "Creating users..."
users = []

# Create admin user
admin = User.create!(
  name: "Admin User",
  username: "admin",
  email: "admin@odinbook.com",
  password: "password123",
  bio: "I am admin of this social network!",
  profile_picture: "https://picsum.photos/seed/admin/200/200.jpg"
)
users << admin

# Create sample users
10.times do |i|
  user = User.create!(
    name: Faker::Name.name,
    username: "#{Faker::Internet.username(specifier: 5..10)}_#{i}",
    email: Faker::Internet.email,
    password: "password123",
    bio: Faker::Lorem.sentence(word_count: 10),
    profile_picture: "https://picsum.photos/seed/user#{i}/200/200.jpg"
  )
  users << user
end

puts "Created #{users.count} users"

# Create follow relationships
puts "Creating follow relationships..."
users.each do |user|
  # Each user follows 3-5 other random users (excluding themselves and admin)
  other_users = users.reject { |u| u == user }
  follow_count = rand(3..5)
  
  other_users.sample(follow_count).each do |followed_user|
    # Check if follow relationship already exists
    unless Follow.exists?(follower: user, followed: followed_user)
      follow = Follow.create!(
        follower: user,
        followed: followed_user,
        status: 'accepted'
      )
      
      # Create reciprocal follow for some relationships
      if rand < 0.3 && !Follow.exists?(follower: followed_user, followed: user)
        Follow.create!(
          follower: followed_user,
          followed: user,
          status: 'accepted'
        )
      end
    end
  end
end

# Create posts
puts "Creating posts..."
users.each do |user|
  post_count = rand(3..8)
  post_count.times do
    post = Post.create!(
      user: user,
      content: Faker::Lorem.paragraph(sentence_count: 2)
    )
    
    # Create likes for posts
    like_count = rand(0..5)
    potential_likers = users.reject { |u| u == post.user }
    potential_likers.sample(like_count).each do |liker|
      Like.create!(
        user: liker,
        post: post
      )
    end
    
    # Create comments for posts
    comment_count = rand(0..3)
    potential_commenters = users.reject { |u| u == post.user }
    comment_count.times do
      Comment.create!(
        user: potential_commenters.sample,
        post: post,
        content: Faker::Lorem.sentence(word_count: 5)
      )
    end
  end
end

puts "Created #{Post.count} posts"
puts "Created #{Like.count} likes"
puts "Created #{Comment.count} comments"
puts "Created #{Follow.count} follow relationships"

puts "Seed data created successfully!"
