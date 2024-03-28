# app/jobs/search_messages_job.rb
class SearchMessagesJob < ApplicationJob
  queue_as :default

  def perform(search_query)
    messages = Message.search(search_query)
    #ActionCable.server.broadcast(messages: messages)
    messages
  end
end
