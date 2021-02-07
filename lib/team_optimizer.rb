class TeamOptimizer
  def self.generate_optimal()   
    defender_benchmark = Player.where(position: 'Defender').order(prediction: :desc)[4].prediction
    defenders = Player.where(position: 'Defender').where('prediction >= ?', defender_benchmark)

    midfielder_benchmark = Player.where(position: 'Midfielder').order(prediction: :desc)[4].prediction
    midfielders = Player.where(position: 'Midfielder').where('prediction >= ?', midfielder_benchmark)

    forward_benchmark = Player.where(position: 'Forward').order(prediction: :desc)[4].prediction
    forwards = Player.where(position: 'Forward').where('prediction >= ?', forward_benchmark)
    
    possible_teams = enumerate_possible_teams(goalies, defenders, midfielders, forwards)
    scores = possible_teams.map { |possible_team| estimate_score(possible_team) }
    scores.sort.first
  end
  
  # Refactor needed - turn below four into one function that takes arguments for position and number of players.

  def self.select_goalie
    goalie_benchmark = Player.where(position: 'Goalkeeper').order(prediction: :desc).first.prediction
    Player.where(position: 'Goalkeeper').where('prediction >= ?', goalie_benchmark)
  end

  def self.select_defenders
    defender_benchmark = Player.where(position: 'Defender').order(prediction: :desc).fifth.prediction
    Player.where(position: 'Defender').where('prediction >= ?', defender_benchmark)
  end

  def self.select_midfielders
    mid_benchmark = Player.where(position: 'Midfielder').order(prediction: :desc).fifth.prediction
    Player.where(position: 'Midfielder').where('prediction >= ?', mid_benchmark)
  end

  def self.select_forwards
    forward_benchmark = Player.where(position: 'Forward').order(prediction: :desc).third.prediction
    Player.where(position: 'Forward').where('prediction >= ?', forward_benchmark)
  end

  def self.enumerate_possible_teams(goalie, defenders, mids, forwards)
    # Create combos of 1 goalie, 3-5 defenders, 2-5 midfielders, 1-3 forwards
  end
  
  def self.estimate_score(possible_team)
  
  end
end