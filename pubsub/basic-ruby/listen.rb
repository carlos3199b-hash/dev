require "google/cloud/pubsub"

project_id = "gen-lang-client-0006306294"
topic_id = "my-topic"
subscription_id = "my-topic-sub"

# Create subscriber client
subscriber_client = Google::Cloud::PubSub::V1::Subscriber::Client.new

# Get paths
subscription_path = subscriber_client.subscription_path(
  project: project_id,
  subscription: subscription_id
)

puts "Listening for messages on #{subscription_id}... (Press Ctrl+C to stop)"

begin
  loop do
    # Pull messages (pull up to 10 messages at a time)
    response = subscriber_client.pull(
      subscription: subscription_path,
      max_messages: 10
    )
    
    if response.received_messages.any?
      response.received_messages.each do |received_message|
        message = received_message.message
        puts "Received: #{message.data}"
        
        # Acknowledge the message
        subscriber_client.acknowledge(
          subscription: subscription_path,
          ack_ids: [received_message.ack_id]
        )
      end
    else
      # No messages, wait a bit before next pull
      sleep(1)
    end
  end
rescue Interrupt
  puts "\nStopping subscriber..."
end