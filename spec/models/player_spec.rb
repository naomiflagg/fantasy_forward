require 'rails_helper'

RSpec.describe Player, type: :model do
  before(:all) do
    @player = create(:player)
    100.times do
      create(:player)
    end
  end

  describe '#select_goalie' do
    it 'selects top goalie' do
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
