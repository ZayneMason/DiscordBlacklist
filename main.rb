require "discordrb"
config = File.foreach("config.txt").map {|line| line.split(' ').join(' ')}
token = config[0].to_s
bot = Discordrb::Commands::CommandBot.new token: "#{token}", client_id: "#{config[1].to_s}" , prefix: "dr! " , ignore_bots: true
blacklist = File.foreach("blacklist.txt").map {|line| line.split(' ').join(' ')}



bot.ready do |event|
  puts "Logged in as #{bot.profile.username} (ID:#{bot.profile.id}) | #{bot.servers.size} servers"
end

bot.command :testing do |event|
  event.respond "I'm working. #{event.user.mention}"
end

bot.message do |message|
  if blacklist.include?(message.content.downcase.delete(' '))
    message.respond "You're weird #{message.user.mention}"
    message.respond "Check this out later #{message.server.roles[28].mention}"
  end
end


bot.run

