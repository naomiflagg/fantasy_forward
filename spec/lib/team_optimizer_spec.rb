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
    before(:all) do
      @defender1 = create(:player, position: 'Defender', prediction: 101)
      @defender2 = create(:player, position: 'Defender', prediction: 100)
      @defender3 = create(:player, position: 'Defender', prediction: 99)
      @defender4 = create(:player, position: 'Defender', prediction: 102)
      @defender5 = create(:player, position: 'Defender', prediction: 101)
      @defender6 = create(:player, position: 'Defender', prediction: 98)
      @defenders = TeamOptimizer.select_defenders
    end

    context 'when there is no tie in scores' do
      it 'selects only 5' do
        expect(@defenders.count).to eq(5)
      end

      it 'selects top 5' do
        expect(@defenders.include?(@defender1)).to be true
        expect(@defenders.include?(@defender2)).to be true
        expect(@defenders.include?(@defender3)).to be true
        expect(@defenders.include?(@defender4)).to be true
        expect(@defenders.include?(@defender5)).to be true
      end
    end

    context 'when fifth top sore is shared' do
      it 'selects all defenders with that score' do
        defender7 = create(:player, position: 'Defender', prediction: 99)
        defenders = TeamOptimizer.select_defenders
        expect(defenders.include?(defender7)).to be true
        expect(defenders.count).to eq(6)
      end
    end

    it 'does not include defender with lower score' do
      expect(@defenders.include?(@defender6)).to be false
    end
  end

  describe '#select_midfielders' do
    before(:all) do
      @mid1 = create(:player, position: 'Midfielder', prediction: 101)
      @mid2 = create(:player, position: 'Midfielder', prediction: 99)
      @mid3 = create(:player, position: 'Midfielder', prediction: 102)
      @mid4 = create(:player, position: 'Midfielder', prediction: 102)
      @mid5 = create(:player, position: 'Midfielder', prediction: 101)
      @mid6 = create(:player, position: 'Midfielder', prediction: 98)
      @mids = TeamOptimizer.select_midfielders
    end

    context 'when there is no tie in scores' do
      it 'selects only 5' do
        expect(@mids.count).to eq(5)
      end

      it 'selects top 5' do
        expect(@mids.include?(@mid1)).to be true
        expect(@mids.include?(@mid2)).to be true
        expect(@mids.include?(@mid3)).to be true
        expect(@mids.include?(@mid4)).to be true
        expect(@mids.include?(@mid5)).to be true
      end
    end

    context 'when fifth top sore is shared' do
      it 'selects all defenders with that score' do
        mid7 = create(:player, position: 'Midfielder', prediction: 99)
        mids = TeamOptimizer.select_midfielders
        expect(mids.include?(mid7)).to be true
        expect(mids.count).to eq(6)
      end
    end

    it 'does not include defender with lower score' do
      expect(@mids.include?(@mid6)).to be false
    end
  end

  describe '#select_forwards do' do
    before(:all) do
      @forward1 = create(:player, position: 'Forward', prediction: 101)
      @forward2 = create(:player, position: 'Forward', prediction: 100)
      @forward3 = create(:player, position: 'Forward', prediction: 101)
      @forward4 = create(:player, position: 'Forward', prediction: 99)
      @forwards = TeamOptimizer.select_forwards
    end

    context 'when there is no tie in scores' do
      it 'selects only 3' do
        expect(@forwards.count).to eq(3)
      end

      it 'selects top 3' do
        expect(@forwards.include?(@forward1)).to be true
        expect(@forwards.include?(@forward2)).to be true
        expect(@forwards.include?(@forward3)).to be true
      end
    end

    context 'when fifth top sore is shared' do
      it 'selects all defenders with that score' do
        forward5 = create(:player, position: 'Forward', prediction: 100)
        forwards = TeamOptimizer.select_forwards
        expect(forwards.include?(forward5)).to be true
        expect(forwards.count).to eq(4)
      end
    end

    it 'does not include defender with lower score' do
      expect(@forwards.include?(@forward4)).to be false
    end
  end
end
