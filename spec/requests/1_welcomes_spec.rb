RSpec.describe 'WelcomesController', type: :request do
  describe '/welcomes へGETリクエストした時' do
    let(:path) { '/welcomes' }
    before do
      get path
      expect(response.status).to eq 200
    end

    it 'RUNTEQという文字が追記されている' do
      expect(response.body).to match('Rails version'), 'Rails version という文字を表示するようにしてください'
      expect(response.body).to match('RUNTEQ'), 'RUNTEQ という文字を表示するようにしてください'
    end
  end
end
