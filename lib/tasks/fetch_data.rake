include ActionView::Helpers::NumberHelper
namespace :fetch_data do
  desc "TODO"
  task fetch_info: :environment do
    require 'csv'
    require 'insta_scrape'
    csv_text = File.read("lib/instagram-list-Task-.csv")
    users = CSV.parse(csv_text)
    users.flatten!
    users.each do |user|
      p user
      engagement = []
      begin
        ig_user = InstaScrape.user_info_and_posts(user,include_meta_data: true)
      rescue
        ig_user = InstaScrape.user_info_and_posts(user,include_meta_data: true)
      end

      if ig_user==nil
        next
      end
      if ig_user.follower_count == nil || ig_user.following_count == nil || ig_user.post_count == nil
        ig_user = InstaScrape.user_info_and_posts(user,include_meta_data: true)
      end
      following = ValidateSuffixedNumber.parse_number(ig_user.following_count.to_s.delete(',')).to_i
      followers = ValidateSuffixedNumber.parse_number(ig_user.follower_count.to_s.delete(',')).to_i
      u = User.create(name: ig_user.username,email: ig_user.email, followers: followers,
                      following: following, number_of_posts: ig_user.post_count, is_winkl: ig_user.is_winkl)

      ig_user.posts.each do |ig_post|
        eng = (((ig_post.likes.to_f+ig_post.comments.to_f)/followers.to_f)*100).round(2)
        comments = ValidateSuffixedNumber.parse_number(ig_post.comments.to_s.delete(',')).to_i
        engagement << eng
        p = Post.create(user_id: u.id, link: ig_post.link,likes: ig_post.likes,
                        engagement: number_to_percentage(eng), hashtags: ig_post.hashtags, comments: comments)

      end
      avg_engagement = (engagement.instance_eval { reduce(:+) / size.to_f })
      u.update_attributes(avg_engagement: number_to_percentage(avg_engagement))
    end
  end

end
