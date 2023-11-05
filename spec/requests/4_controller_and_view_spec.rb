RSpec.describe 'コントローラとビュー', type: :request do
  describe 'UsersControllerで' do
    let!(:user) { create(:user) }

    before do
      get path
      expect(response.status).to eq 200
    end

    context 'indexアクション' do
      let(:path) { '/users' }

      it 'ユーザー一覧という文字が表示されている' do
        expect(controller.instance_variable_get("@index_title")).to eq('ユーザー一覧')
        expect(controller.respond_to?(:set_index_title, true)).to eq(true)
        expect(response.body).to match('ユーザー一覧'), 'ユーザー一覧 という文字を表示するようにしてください'
      end
    end

    context 'showアクション' do
      let(:path) { user_path(user) }

      it 'ユーザー詳細という文字が表示されている' do
        expect(controller.instance_variable_get("@show_title")).to eq('ユーザー詳細')
        expect(controller.respond_to?(:set_show_title, true)).to eq(true)
        expect(response.body).to match('ユーザー詳細'), 'ユーザー詳細 という文字を表示するようにしてください'
      end
    end
  end
end
