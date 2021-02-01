require 'rails_helper'
require 'team_optimizer'
require 'pry'

RSpec.describe 'team_optimizer' do
  before(:all) do
    100.times do
      create(:player)
    end
    @goalie = create(:player, position: 'Goalkeeper', prediction: 101)
    @bad_goalie = create(:player, position: 'Goalkeeper', prediction: 100)
  end

  describe '#select_goalie' do
    context 'when there is no tie in scores' do
      it 'selects one top goalie' do
        goalie = TeamOptimizer.select_goalie
        expect(goalie.include?(@goalie)).to be true
      end
    end

    context 'when top score is shared' do
      it 'selects all goalies with that score' do
        goalie2 = create(:player, position: 'Goalkeeper', prediction: 101)
        goalie = TeamOptimizer.select_goalie
        expect(goalie.include?(goalie2)).to be true
        expect(goalie.include?(@goalie)).to be true
      end
    end

    it 'does not include goalie with lower score' do
      goalie = TeamOptimizer.select_goalie
      expect(goalie.include?(@bad_goalie)).to be false
    end
  end

  describe '#select_defenders' do
    it 'selects top 5 defenders' do
    end
  end

  describe '#select_midfielders' do
    it 'selects top 5 midfielders' do
    end
  end

  describe '#select_forwards do' do
    it 'selects top 3 forwards do' do
    end
  end
end
