# app/models/concerns/message.rb
class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json(options={})
    self.as_json(except: [:id, :created_at, :updated_at])
  end
end
