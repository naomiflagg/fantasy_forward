# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'httparty'
require 'json'



def teams
  Team.destroy_all
  response = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
  response.parsed_response
  unless response.nil?
    response['teams'].each do |team|
      Team.create(name: "#{team['name']}", code: "#{team['code']}")
    end
  else
    puts 'error seeding teams'
  end
end

def players
  positions = {1 => 'Goalkeeper', 2 => 'Defender', 3 => 'Midfielder', 4 => 'Forward'}
  Player.delete_all
  response = HTTParty.get('https://fantasy.premierleague.com/api/bootstrap-static/')
  response.parsed_response
  unless response.nil?
    response['elements'].each do |element|
      if element['status'] == 'a'
        Player.create(first_name: "#{element['first_name']}", last_name: "#{element['second_name']}", goals: "#{element['goals_scored']}", assists: "#{element['assists']}", clean_sheets: "#{element['clean_sheets']}", points: "#{element['total_points']}", position: "#{positions[element['element_type']]}", team: Team.find_by(code: "#{element['team_code']}"))
      end
    end
  end
end

teams
players