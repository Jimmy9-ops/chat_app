# app/models/application.rb
class Application < ApplicationRecord
    has_many :chats #,counter_cache: true
    before_create :generate_token

    def as_json(options = {})
     super(options.merge(except: [:id]))
    end

    private

    def generate_token
      self.chats_count = 0
      self.token = SecureRandom.hex(16)
    end
  end
