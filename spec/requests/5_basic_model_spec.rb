RSpec.describe 'コントローラとビュー', type: :request do
  describe 'UsersControllerで' do
    let(:ages) { [19, 20, 21, 50, 51] }
    before do
      ages.each { |age| create(:user, age: age) }
      get path
      expect(response.status).to eq 200
    end

    context 'indexアクション' do
      let(:path) { '/users' }

      it '20歳から50歳までのユーザーが年齢の逆順に並べられている' do
        users = controller.instance_variable_get("@users")
        expect(users.size).to eq(3)
        expect(users.map(&:age)).to eq([50, 21, 20])
        expect(response.body).to match('ユーザー一覧'), 'ユーザー一覧 という文字を表示するようにしてください'
      end
    end

    context 'newアクション' do
      let(:path) { new_user_path }

      it '新規作成という文字が表示されている' do
        user = controller.instance_variable_get("@user")
        expect(user.name).to eq('らんてくん'), 'ユーザーの初期名前を"らんてくん"にしてください'
        expect(user.age).to eq(20), 'ユーザーの初期年齢を"20歳"にしてください'
        expect(response.body).to match('新規作成'), '新規作成 という文字を表示するようにしてください'
      end
    end
  end
end
