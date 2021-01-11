# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'httparty'
require 'json'

def teams
  response = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
  response.parsed_response

  if !response.nil?
    response['teams'].each do |team|
      Team.find_or_create_by(name: "#{team['name']}")
    end
  else
    puts 'error seeding teams'
  end
end

teams