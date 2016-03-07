cucubot
=======

An IRC bot to assist with the cucushift project.

In order to run the bot, several environmental variables must be set:
```bash
CUCUBOT_NICK
CUCUBOT_REALNAME
CUCUBOT_SERVER_IP
CUCUBOT_SERVER_PORT
CUCUSHIFT_IRC_CHANNEL
CUCUBOT_SCRUM5000 (The URL of the scrum5000 app, to query for users)
```

The bot will reply to commands, query a rails app, and return values
via REST.

A .openshift directory is included to run cucubot in an OpenShift ruby app.
When running on OpenShift, logs will be stored in the $OPENSHIFT\_DATA\_DIR directory

Cucubot will also report scrums and list previously reported scrums.

For example:
cucubot: !log\_scrum (2015-11-23, enter date if not today, otherwise will assume today) :yesterday xyz :today xyz :blockers xyz
cucubot: !show\_scrum 2015-11-23 (will list all users)
cucubot: show\_scrum 2015-11-23 user1 (will list specific user)

