require 'cinch'

class FileAScrum
  include Cinch::Plugin

  #When a user writes !file_scrum, call the file_scrum method below.
  #By default, cinch Plugins take a default prefix of /^!/ which
  #means the actual match is !hello
  match "file_scrum", method: :file_scrum
  match /show_scrum( d\+)/, method: show_scrum

  def file_scrum(m)
      m.reply "You're filing a scrum."
  end
end
