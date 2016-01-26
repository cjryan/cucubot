require 'cinch'

class FileAScrum
  include Cinch::Plugin

  #When a user writes !file_scrum, call the file_scrum method below.
  #By default, cinch Plugins take a default prefix of /^!/ which
  #means the actual match is !hello
  match "file_scrum", method: :file_scrum
  match /show_scrum( d\+)/, method: :show_scrum

  def file_scrum(m)
    # m.user.nick -> nick who sent message
    # m.message -> user message

    #m.reply "You're filing a scrum."
    if m.message !~ /:yesterday( \w+)/
      m.reply "You're missing yesterday's report."
    end
  end

  def show_scrum(m)
    m.reply "You're showing a scrum."
  end
end
