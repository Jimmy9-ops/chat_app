# app/workers/create_message_worker.rb
require 'redis'

class CreateMessageWorker
  include Sidekiq::Worker

  def perform(chat_id, body,application_id)

    application = Application.find( application_id)
    chat = application.chats.find_by(chat_number: chat_id)

    redis = Redis.new(url: 'redis://redis:6379')

    # Acquire a lock for the message
    lock_key = "lock:chat:#{chat_id}"
    lock_expire_time = 10 # Set lock expiry time in seconds
    lock_acquired = redis.set(lock_key, "LOCKED", nx: true, ex: lock_expire_time)

    if lock_acquired
      begin
        # Process the message creation logic (e.g., create message in database)
        last_chat = chat.messages.order(message_number: :desc).first
        number = last_chat ? last_chat.message_number+ 1 : 1
        message = chat.messages.create!(body.merge(message_number: number))

        # Simulate some processing time
        #sleep 5

        puts "Message created: #{message.id}"

        return message
      ensure
        # Release the lock
        redis.del(lock_key)
      end
    else
      puts "Failed to acquire lock for chat #{chat_id}"
    end
  rescue ActiveRecord::RecordNotFound
    # Handle record not found error
  end
end
