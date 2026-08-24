password = "demo1234"

people = [
  {
    email: "maya@socialrails.dev",
    username: "maya",
    name: "Maya Chen",
    github_username: "maya",
    bio: "Rails since 2.3. I like chronological feeds and small software."
  },
  {
    email: "arjun@socialrails.dev",
    username: "arjun",
    name: "Arjun Patel",
    github_username: "arjun",
    bio: "Postgres, indexes, and tea. Building in public from Bengaluru."
  },
  {
    email: "lena@socialrails.dev",
    username: "lena",
    name: "Lena Okonkwo",
    github_username: "lena",
    bio: "Designer who ships ERB. Hotwire convert."
  },
  {
    email: "theo@socialrails.dev",
    username: "theo",
    name: "Theo Berg",
    github_username: "theoberg",
    bio: "Background jobs, queues, and leaving work on time."
  },
  {
    email: "priya@socialrails.dev",
    username: "priya",
    name: "Priya Nair",
    github_username: "priya",
    bio: "Docs, DX, and the sentence that makes an API obvious."
  },
  {
    email: "jonah@socialrails.dev",
    username: "jonah",
    name: "Jonah Hale",
    github_username: "jonah",
    bio: "I break production so you don’t have to. Then I write the postmortem."
  },
  {
    email: "sofia@socialrails.dev",
    username: "sofia",
    name: "Sofia Reyes",
    github_username: "sofia",
    bio: "Accessibility is a feature. Contrast is a kindness."
  },
  {
    email: "kenji@socialrails.dev",
    username: "kenji",
    name: "Kenji Mori",
    github_username: "kenji",
    bio: "Types in Ruby when they help. No types when they don’t."
  }
]

users = people.map do |attrs|
  User.find_or_initialize_by(email: attrs[:email]).tap do |user|
    user.assign_attributes(attrs.merge(password: password, password_confirmation: password))
    user.save!
  end
end

maya, arjun, lena, theo, priya, jonah, sofia, kenji = users

{
  maya => [ arjun, lena, theo, priya ],
  arjun => [ maya, priya, kenji ],
  lena => [ maya, sofia, jonah ],
  theo => [ maya, arjun, jonah ],
  priya => [ arjun, sofia ],
  jonah => [ theo, lena, kenji ],
  sofia => [ lena, priya, maya ],
  kenji => [ arjun, jonah ]
}.each do |follower, followed|
  followed.each { |other| follower.follow(other) }
end

posts_data = [
  [ maya, "Newest first. No ranking. If the square is quiet, that is a feature.", "https://github.com/rails/rails", 6.hours ],
  [ arjun, "Put the social graph in Postgres. Follows are just rows. You can explain it on a whiteboard.", nil, 5.hours ],
  [ lena, "Shipped a feed today with ERB and Turbo. Recruiters keep asking where the React app is. There isn’t one.", nil, 4.hours ],
  [ theo, "Action Cable on a single Puma process is enough for a yard this size. Don’t start with Redis.", nil, 3.hours ],
  [ priya, "Your README is the product for hiring. Three minutes, a demo login, a screenshot of live likes.", "https://github.com/hotwired/turbo-rails", 2.hours ],
  [ jonah, "CSRF skipped on posts is how 2015 apps died in production. Owner-only destroy. Always.", nil, 90.minutes ],
  [ sofia, "If the like button doesn’t have a name a screen reader can speak, it isn’t done.", nil, 70.minutes ],
  [ kenji, "I linked the Rails repo because this square is for builders. Optional URL. No tracking pixels.", "https://rubyonrails.org", 40.minutes ],
  [ maya, "Demo accounts are seeded so a new login isn’t an empty world. That’s hospitality.", nil, 25.minutes ]
]

posts = posts_data.map do |author, body, link, ago|
  post = Post.find_or_initialize_by(user: author, body: body)
  post.link_url = link
  post.created_at = ago.ago
  post.updated_at = ago.ago
  post.save!
  post
end

Comment.find_or_create_by!(post: posts[0], user: arjun, body: "This is the whole pitch. Put it in the header.")
Comment.find_or_create_by!(post: posts[0], user: lena, body: "And keep the type large. Serif for the square, sans for chrome.")
Comment.find_or_create_by!(post: posts[2], user: sofia, body: "Hotwire is the demo. Click like twice and watch it move.")
Comment.find_or_create_by!(post: posts[4], user: maya, body: "Yes. maya@socialrails.dev / demo1234.")
Comment.find_or_create_by!(post: posts[5], user: kenji, body: "Pundit on destroy. Tests on ‘cannot delete someone else’s post’.")

[ arjun, lena, theo, priya ].each { |u| posts[0].likes.find_or_create_by!(user: u) }
[ maya, sofia ].each { |u| posts[2].likes.find_or_create_by!(user: u) }
[ jonah, kenji, theo ].each { |u| posts[5].likes.find_or_create_by!(user: u) }
posts[4].likes.find_or_create_by!(user: lena)

convo = Conversation.find_or_create_between(maya, arjun)
DirectMessage.find_or_create_by!(conversation: convo, user: maya, body: "The square looks lived-in. Seeds were the right call.")
DirectMessage.find_or_create_by!(conversation: convo, user: arjun, body: "Come say hi in the Yard after you ship the README.")

convo2 = Conversation.find_or_create_between(lena, sofia)
DirectMessage.find_or_create_by!(conversation: convo2, user: lena, body: "Contrast on the rust button — can you check it?")
DirectMessage.find_or_create_by!(conversation: convo2, user: sofia, body: "Checked. Paper on rust is fine. Don’t grey out Following.")

yard = [
  [ kenji, "Yard is open. One room, no channels.", 3.hours ],
  [ theo, "If this blanks after 15 minutes on Render free, that’s spin-down. Refresh once.", 2.hours ],
  [ priya, "Someone starring the repo does not mean they read the case study. Lead with the live like.", 50.minutes ],
  [ maya, "Welcome. Newest first. Stay as long as you like.", 10.minutes ]
]
yard.each do |user, body, ago|
  msg = ChatMessage.find_or_initialize_by(user: user, body: body)
  msg.created_at = ago.ago
  msg.updated_at = ago.ago
  msg.save!
end

puts "Seeded #{User.count} people, #{Post.count} posts, #{Follow.count} follows. Demo password: #{password}"
