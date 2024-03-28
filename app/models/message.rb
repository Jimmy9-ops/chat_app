require 'elasticsearch/model'

class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  belongs_to :chat
  after_create_commit :update_chat_messages_count

  # Optimistic locking
  lock_optimistically

  def as_json(options = {})
  super(options.merge(except: [:id,:chat_id]))
 end

  mapping do
  indexes :body, type: 'text'
  end

  private

  def update_chat_messages_count
    chat.increment!(:messages_count)
  end
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :body, analyzer: 'english'
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:body])
  end
end
