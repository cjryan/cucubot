require 'isaac'

#Connect to the cucushift irc channel, taken from the isaac github guide.
#The 'verbose' options shows all output in the terminal window, which is
#useful for monitoring channel activity.
configure do |c|
  c.nick = "$nick_here"
  c.server = "$irc_server_here"
  c.port = "$irc_port_here"
  c.verbose = true
end

#for the $channel_here var below, prefix the string with a #, as in #cucushift
on :connect do
  join "$channel_here"
end
