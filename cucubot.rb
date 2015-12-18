require 'cinch'
require 'json'
require 'open-uri'
require_relative 'plugins/laggard_plugin'
require_relative 'plugins/file_a_scrum'


#Connect to the cucushift irc channel, taken from the cinch github guide.
@cucubot = Cinch::Bot.new do
  configure do |c|
    c.nick = ENV['CUCUBOT_NICK']
    c.realname = ENV['CUCUBOT_REALNAME']
    c.server = ENV['CUCUBOT_SERVER_IP']
    c.port = ENV['CUCUBOT_SERVER_PORT']
    c.channels = [ENV['CUCUSHIFT_IRC_CHANNEL']]
    c.plugins.plugins = [LaggardPlugin]
    c.plugins.plugins = [FileAScrum]
    #c.ping_interval = 30
  end

  #for the $channel_here var below, prefix the string with a #, as in #cucushift
  #on :connect do
  #    User('testuser').send("Hello!")
  #end

  #Query for users who have not logged a scrum today
  on :message, "laggards" do |m|
    #if nothing reply "No laggards today!"
    #else, show the list of laggards
    response = open("#{ENV['CUCUBOT_SCRUM5000']}/bot_portal/bot_checkpoint.json").read
    if response.empty?
      m.reply "No laggards today!"
    else
      parsed = JSON.parse(response)
      parsed.each do |unreported|
       user_irc_nick = unreported[1][0]
       m.reply user_irc_nick
      end
    end
  end
end

@cucubot.start
