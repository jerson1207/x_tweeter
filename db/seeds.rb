10.times do |i|
  user = User.create!(
    email: "user#{i+1}@example.com",
    password: 'qwerty',
    password_confirmation: 'qwerty'
  )

  # Create 3 tweets for each user
  3.times do
    user.tweets.create!(
      body: Faker::Lorem.sentence
    )
  end
end