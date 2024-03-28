require 'redis'

class CreateChatWorker
  include Sidekiq::Worker

  def perform(application_id)
    application = Application.find(application_id)

    redis = Redis.new(url: 'redis://redis:6379')

    lock_key = "lock:application:#{application_id}"
    lock_expire_time = 10 # Set lock expiry time in seconds
    lock_acquired = redis.set(lock_key, "LOCKED", nx: true, ex: lock_expire_time)

    if lock_acquired
      begin
        Rails.logger.info "Chat creation job started"

        # Process the chat creation logic (e.g., create chat in database)
        last_chat = application.chats.order(chat_number: :desc).first
        number = last_chat ? last_chat.chat_number + 1 : 1
        chat = application.chats.create!(chat_number: number)

        # Simulate some processing time
        #sleep 5

        Rails.logger.info "Chat created: #{chat.id}"

        return chat # Return the created chat object
      ensure
        redis.del(lock_key)
      end
    else
      Rails.logger.error "Failed to acquire lock for application #{application_id}"
      return nil # Return nil if lock was not acquired
    end

  rescue ActiveRecord::RecordNotFound
    # Handle record not found error
    return nil # Return nil in case of error
  end
end
=begin
# app/workers/create_chat_worker.rb
class CreateChatWorker
  include Sidekiq::Worker

  def perform(application_id)
    application = Application.find(application_id)
    chat = application.chats.create(chat_number: next_chat_number(application))

    Rails.logger.info "Chat created: #{chat.inspect}"

    chat # Return the created chat object
  end

  private

  def next_chat_number(application)
    last_chat = application.chats.order(chat_number: :desc).first
    last_chat ? last_chat.chat_number + 1 : 1
  end
end
=end
