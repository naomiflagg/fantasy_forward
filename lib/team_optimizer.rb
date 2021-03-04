require 'set'

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

  # # To do: split below function in to several pieces
  # def self.create_team
  #   team = []
  #   # Doesn't take into account ties
  #   select_goalie.each { |goalie| team.push(goalie) }
  #   defenders = select_defenders
  #   defenders.limit(3).each { |defender| team.push(defender) }
  #   mids = select_midfielders
  #   mids.limit(2).each { |mid| team.push(mid) }
  #   forwards = select_forwards
  #   forwards.limit(1).each { |fwd| team.push(fwd) }
  #   d_pointer = 3
  #   m_pointer = 2
  #   f_pointer = 1
  #   4.times do
  #     defender = defenders[d_pointer]
  #     d_pred = defender.nil? ? 0 : defender.prediction
  #     mid = mids[m_pointer]
  #     m_pred = mid.nil? ? 0 : mid.prediction
  #     forward = forwards[f_pointer]
  #     f_pred = forward.nil? ? 0 : forward.prediction
  #     if d_pred >= m_pred && d_pred >= f_pred
  #       team.push(defender)
  #       d_pointer += 1
  #     elsif m_pred >= d_pred && m_pred >= f_pred
  #       team.push(mid)
  #       m_pointer += 1
  #     else
  #       team.push(forward)
  #       f_pointer += 1
  #     end
  #   end
  #   team
  # end

  def self.create_team
    top = Player.order(prediction: :desc)
    @positions_counter = { 'Goalkeeper' => 0, 'Defender' => 0, 'Midfielder' => 0, 'Forward' => 0 }
    @teams_counter = {}
    Team.all.each { |team| teams_counter[team.name] = 0 }
    team = []
    pointer = 0
    while team.length < 11 || top[pointer + 1].prediction == top[pointer].prediction
      add_player(top[pointer])
      
    end
  end

  def add_player(player)
    @teams_counter[player.team] >= 3 ? return : @teams_counter[player.team] += 1

    position = player.position

  end


  def recursive_create
    players = Player.all
    cache = {}

    add_player = lambda do |player, team, index|
      puts player, team, index
      curr_points = cache[team] || 0
      team.add(player)

      # Base case
      return if cache[team]

      # Add predicted points to team set cache
      cache[team] = curr_points + player.prediction

      # More base cases
      return if team.length == 11
      return if team.length < 11 && index == players.length - 1

      (index + 1...players.length).each do |i|
        player_to_add = players[i]
        positions = calc_positions(team)
        position = player_to_add.position
        curr_of_position = positions[position]
        next unless allowed_position?(position, curr_of_position)

        teams = calc_teams(team)
        player_team = player_to_add.team.name
        curr_of_team = teams[player_team]
        next if curr_of_team >= 3

        add_player.call(player_to_add, team, i)
      end
    end

    players.each_with_index do |player, ind|
      team_set = Set.new
      team_set.add(player)
      add_player.call(player, team_set, ind)
    end

    cache.max_by{ |k, v| v }
  end

  def calc_positions(team)
    team.reduce(Hash.new(0)) do |result, player|
      result[player.position] += 1
      result
    end
  end

  def allowed_position?(position, curr_of_position)
    case position
    when 'Goalkeeper'
      false if curr_of_position >= 1
    when 'Defender'
      false if curr_of_position >= 5
    when 'Midfielder'
      false if curr_of_position >= 5
    when 'Forward'
      false if curr_of_position >= 3
    else
      true
    end
  end

  def calc_teams(team)
    team.reduce(Hash.new(0)) do |result, player|
      result[player.team.name] += 1
      result
    end
  end
end
