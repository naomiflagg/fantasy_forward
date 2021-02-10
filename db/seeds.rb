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
  response = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
  response.parsed_response
  if response.nil?
    puts 'error seeding players'
  else
    response['elements'].each do |element|
      f_name = element['first_name'].to_s
      l_name = element['second_name'].to_s
      player = Player.where(first_name: f_name, last_name: l_name).first_or_initialize
      player.update!(goals: element['goals_scored'], assists: element['assists'],
                     clean_sheets: element['clean_sheets'], points: element['total_points'], position: (positions[element['element_type']]).to_s, prediction: element['ep_next'], team: Team.find_by(code: (element['team_code']).to_s))
    end
  end
end

players
