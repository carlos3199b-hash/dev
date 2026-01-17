require "google/cloud/pubsub"

project_id = "gen-lang-client-0006306294"
topic_id   = "my-topic"

pubsub = Google::Cloud::PubSub.new(project_id: project_id)

# topic_path only takes the topic_id (project is already set)
topic_path = pubsub.topic_path(topic_id)

begin
  pubsub.topic_admin.create_topic(name: topic_path)
  puts "Topic created: #{topic_id}"
rescue Google::Cloud::AlreadyExistsError
  puts "Topic already exists"
rescue => e
  puts "Error: #{e.message}"
end

# Publish message
publisher = pubsub.service
message_data = "Bye from Pub/Sub!"
result = publisher.publish(topic_path, [{ data: message_data }])
puts "Message published!"