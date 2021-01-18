require 'rails_helper'
require 'team_optimizer'

RSpec.describe "team_optimizer" do

  before(:all) do
    100.times do
      create(:player)
    end
  end

  describe '#select_goalie' do
    context 'when there is no tie in scores' do
      it 'selects one top goalie' do
        player = create(:player, prediction: 100)
      end
    end

    context 'when top score is shared' do
      it 'selects all goalies with that score' do
      end
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
