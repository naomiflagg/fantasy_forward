require 'rails_helper'

RSpec.describe Team, type: :model do
  before(:each) do
    @team = Team.new
  end

  describe 'associations' do
    it { should have_many(:players) }
  end
end
