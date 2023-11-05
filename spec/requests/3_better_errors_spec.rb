RSpec.describe "better_errors", type: :request do
  describe 'BetterErrorsを' do
    it 'インストールしている' do
      expect(defined? BetterErrors).to eq('constant')
    end
  end
end
