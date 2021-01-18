class TeamOptimizer
  def self.generate_optimal()
    goalie = Player.where(type: :goalie).order(score: :desc).limit(1).first
    defenders = Player.where(type: :defender).order(score: :desc).limit(5)
    mids = Player.where(type: :mid).order(score: :desc).limit(1)
    forwards = Player.where(type: :forward).order(score: :desc).limit(1)
    
    possible_teams = enumerate_possible_teams(goalie, defenders, mids, forwards)
    scores = possible_teams.map { |possible_team| estimate_score(possible_team) }
    scores.sort.first
  end
  
  def self.enumerate_possible_teams(goalie, defenders, mids, forwards)
    # Create combos of 1 goalie, 3-5 defenders, 2-5 midfielders, 1-3 forwards
  end
  
  def self.estimate_score(possible_team)
  
  end
end