# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'httparty'
require 'json'

# Run once before season begins
def seed_teams
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

def seed_players
  Player.destroy_all
  positions = { 1 => 'Goalkeeper', 2 => 'Defender', 3 => 'Midfielder', 4 => 'Forward' }
  response = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
  response.parsed_response
  if response.nil?
    puts 'error seeding players'
  else
    response['elements'].each do |element|
      Player.create do |p|
        p.first_name = element['first_name'].to_s
        p.goals = element['goals_scored']
        p.assists = element['assists']
        p.last_name = element['second_name'].to_s
        p.clean_sheets = element['clean_sheets']
        p.points = element['total_points']
        p.position = (positions[element['element_type']]).to_s
        p.prediction = element['ep_next']
        p.team = Team.find_by(code: (element['team_code']).to_s)
      end
    end
  end
end

seed_players
