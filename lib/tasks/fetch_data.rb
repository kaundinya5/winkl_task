require 'csv'
require 'insta_scrape'
csv_text = File.read("../instagram-list-Task-.csv")
users = CSV.parse(csv_text)
users.flatten!
users.shift
users.each do |user|
  engagement = []
  ig_user = InstaScrape.user_info_and_posts(user,i  nclude_meta_data: true)
  if ig_user==nil
    next
  end
  ig_user.posts.each do |ig_post|
    eng = (ig_post.likes+ig_post.comments)/ig_user.follower_count
    engagement << eng
    Post.create(user: ig_user.username, link: ig_post.link,likes: ig_post.likes,
                engagement: eng, hashtags: ig_post.hashtags)
  end
  avg_engagement = engagement.instance_eval { reduce(:+) / size.to_f }
  User.create(name: ig_user.username,email: ig_user.email, followers: ig_user.follower_count,
              following: ig_user.following_count, number_of_posts: ig_user.post_count,
              avg_engagement: avg_engagement)
end