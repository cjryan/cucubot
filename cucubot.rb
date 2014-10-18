require 'cinch'
require 'json'
require 'open-uri'

#Borrowed heavily from https://raw.githubusercontent.com/cinchrb/cinch/master/examples/plugins/timer.rb
class LaggardPlugin
  include Cinch::Plugin
  #Every five hours (18000 seconds) run the 'check_scrums' method
  timer 18000, method: :check_scrums
  def check_scrums
    #Check the scrum5000 app for users who have and have not filled out a scrum
    #If response is empty, everyone filled out a scrum, otherwise, send a private
    #message to the person.
    response = open("#{ENV['CUCUBOT_SCRUM5000']}/bot_portal/bot_checkpoint.json").read
    if response.empty?
      #Uncomment the following line to spam the channel with an all-clear message
      #Channel(ENV['CUCUSHIFT_IRC_CHANNEL']).send "No laggards today!"
      puts "No laggards today!"
    else
      parsed = JSON.parse(response)
      parsed.each do |unreported|
        #Uncomment the below line to spam the channel with users
        #who have not yet filled out a scrum
        #Channel(ENV['CUCUSHIFT_IRC_CHANNEL']).send "#{unreported[1]}"

        #Add support for regex when user changes name
        User("#{unreported[1]}").send("#{unreported[1]}, please fill out your scrum today.")
      end
    end
  end
end

#Connect to the cucushift irc channel, taken from the cinch github guide.
cucubot = Cinch::Bot.new do
  configure do |c|
    c.nick = ENV['CUCUBOT_NICK']
    c.realname = ENV['CUCUBOT_REALNAME']
    c.server = ENV['CUCUBOT_SERVER_IP']
    c.port = ENV['CUCUBOT_SERVER_PORT']
    c.channels = [ENV['CUCUSHIFT_IRC_CHANNEL']]
    c.plugins.plugins = [LaggardPlugin]
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
       m.reply unreported[1]
      end
    end
  end
end

cucubot.start
