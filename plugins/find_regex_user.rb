require 'cinch'

class FindRegexUser
  include Cinch::Plugin
  def find(scrum_user)
    user_list = []
    channel = Channel("#{ENV['CUCUSHIFT_IRC_CHANNEL']}")
    channel.users.each do |user|
      user_list << user.keys.nick
    end
  end
end
