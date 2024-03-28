Elasticsearch::Model.client = Elasticsearch::Client.new(
  log: true, # Set to true to log Elasticsearch queries in the Rails log
  host: 'http://elasticsearch:9200' # Elasticsearch host and port
)
#Elasticsearch::Model.client = Elasticsearch::Client.new(url: 'http://0.0.0.0:9200/')
# Define a method to create the index for the Message model
=begin

end

def create_message_index!
  unless Message.__elasticsearch__.index_exists?
    Message.__elasticsearch__.create_index!
    Message.import
  end
end

# Create the index when the Rails application starts
Rails.application.config.after_initialize do
  create_message_index!
end
=end
