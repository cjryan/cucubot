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
```

The bot will reply to commands, query a rails app, and return values
via REST.

A .openshift directory is included to run cucubot in an OpenShift ruby app.
