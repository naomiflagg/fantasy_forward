# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'httparty'
require 'json'

# Run once before season begins
def teams
  Team.destroy_all
  response = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
  response.parsed_response
  if response.nil?
    puts 'error seeding teams'
  else
    response['teams'].each do |team|
      Team.create(name: (team['name']).to_s, code: (team['code']).to_s)
    end
  end
end

def players
  positions = { 1 => 'Goalkeeper', 2 => 'Defender', 3 => 'Midfielder', 4 => 'Forward' }
  Player.delete_all
  response = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
  response.parsed_response
  if response.nil?
    puts 'error seeding players'
  else
    response['elements'].each do |element|
      if element['status'] == 'a'
        Player.create(first_name: (element['first_name']).to_s, last_name: (element['second_name']).to_s,
                      goals: (element['goals_scored']).to_s, assists: (element['assists']).to_s, clean_sheets: (element['clean_sheets']).to_s, points: (element['total_points']).to_s, position: (positions[element['element_type']]).to_s, prediction: (element['ep_next']).to_s, team: Team.find_by(code: (element['team_code']).to_s))
      end
    end
  end
end

players
