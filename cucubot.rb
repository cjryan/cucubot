require 'cinch'

#Connect to the cucushift irc channel, taken from the isaac github guide.
#The 'verbose' options shows all output in the terminal window, which is
#useful for monitoring channel activity.

cucubot = Cinch::Bot.new do
  configure do |c|
    c.nick = ENV['CUCUBOT_NICK']
    c.server = ENV['CUCUBOT_SERVER_IP']
    c.port = ENV['CUCUBOT_SERVER_PORT']
    c.channels = [ENV['CUCUSHIFT_IRC_CHANNEL']]
  end
end

cucubot.start
#for the $channel_here var below, prefix the string with a #, as in #cucushift
#on :connect do
#  join ENV['CUCUSHIFT_IRC_CHANNEL']
#end
