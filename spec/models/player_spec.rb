require 'rails_helper'

RSpec.describe Player, type: :model do
  before(:each) do
    team = Team.new
    @player = create(:player, first_name: 'First', last_name: 'Last', team: team)
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(@player).to be_valid
    end

    it 'is not valid without a first name' do
      @player.first_name = nil
      expect(@player).to_not be_valid
    end

    it 'is not valid without a last name' do
      @player.last_name = nil
      expect(@player).to_not be_valid
    end

    it 'is not valid without a team' do
      @player.team = nil
      expect(@player).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:team) }
  end

  it { should have_db_index(:position) }
end
