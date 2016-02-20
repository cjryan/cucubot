require 'cinch'
require 'rest-client'

class FileAScrum
  include Cinch::Plugin

  #When a user writes !file_scrum, call the file_scrum method below.
  #By default, cinch Plugins take a default prefix of /^!/ which
  #means the actual match is !hello
  match /file_scrum.*/, method: :file_scrum
  match /show_scrum( d\+)/, method: :show_scrum

  def file_scrum(m)
    # m.user.nick -> nick who sent message
    # m.message -> user message

    #Parse out the user's scrum message
    #Date must be in format YYYY-MM-DD
    #Sprint number is the number of the current sprint, i.e. '110'
    yesterday = m.message.match /:yesterday(\s*\w+)/
    today = m.message.match /:today(\s*\w+)/
    blockers = m.message.match /:blockers(\s*\w+)/
    date = m.message.match /:date(\s*\d{4}-\d{2}-\d{2})/
    sprint = m.message.match /:sprint(\s*\d+)/

    #Create the payload from the user's message
    payload = {}

    payload[:scrum_yesterday] = yesterday[1].strip() unless yesterday.nil?
    payload[:scrum_today] = today[1].strip() unless today.nil?
    payload[:scrum_blockers] = blockers[1].strip() unless blockers.nil?
    payload[:scrum_date] = date[1].strip() unless date.nil?
    payload[:sprint_number] = sprint[1].strip() unless sprint.nil?
    payload[:scrum_user] = m.user.nick

    #Send off the scrum to scrum5000
    url = "#{ENV['CUCUBOT_SCRUM5000']}/bot_portal/bot_filed_scrum"

    begin
      response = RestClient.post(
        url,
        payload,
        :content_type => 'text/plain',
        :accept => :json
      )

      m.reply "#{response}, #{response.code}"
    rescue
      m.reply "Unable to communicate with server; see if Scrum5000 is down."
    end
  end

  def show_scrum(m)
    m.reply "You're showing a scrum."
  end
end
