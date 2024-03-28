 # app/models/chat.rb
 class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages#,counter_cache: true
    after_create :increment_application_chats_count

  # Optimistic locking
  lock_optimistically

    def as_json(options = {})
    super(options.merge(except: [:id,:application_id]))
   end

    private

    def increment_application_chats_count
      self.messages_count = 0
      application.increment!(:chats_count)
    end
  end
