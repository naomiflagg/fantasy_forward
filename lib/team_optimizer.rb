class TeamOptimizer
  # To do: refactor below four into one function that takes arguments for position and number of players.
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

  # To do: split below function in to several pieces
  def self.create_team
    team = []
    # Doesn't take into account ties
    select_goalie.each { |goalie| team.push(goalie) }
    defenders = select_defenders
    defenders.limit(3).each { |defender| team.push(defender) }
    mids = select_midfielders
    mids.limit(2).each { |mid| team.push(mid) }
    forwards = select_forwards
    forwards.limit(1).each { |fwd| team.push(fwd) }
    d_pointer = 3
    m_pointer = 2
    f_pointer = 1
    4.times do
      defender = defenders[d_pointer]
      d_pred = defender.nil? ? 0 : defender.prediction
      mid = mids[m_pointer]
      m_pred = mid.nil? ? 0 : mid.prediction
      forward = forwards[f_pointer]
      f_pred = forward.nil? ? 0 : forward.prediction
      if d_pred >= m_pred && d_pred >= f_pred
        team.push(defender)
        d_pointer += 1
      elsif m_pred >= d_pred && m_pred >= f_pred
        team.push(mid)
        m_pointer += 1
      else
        team.push(forward)
        f_pointer += 1
      end
    end
    team
  end
end
