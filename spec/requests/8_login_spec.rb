RSpec.describe "/login", type: :request do
  let!(:user) { create(:user) }
  let(:params) { { name: user.name, age: user.age } }
  let(:login) { post login_path, params: params }

  describe "GET /login/new" do
    it "正常に表示される" do
      get new_login_path
      expect(response.status).to eq 200

      expect(response.body).to match('ログイン')
      expect(response.body).to match('名前')
      expect(response.body).to match('年齢')
    end
  end

  describe "POST /login" do
    context "名前と年齢が適切な時" do
      it "ログインできる" do
        get root_path
        expect(response.body).not_to match(user.name)

        login

        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to eq "ログインしました"

        get root_path
        expect(response.body).to match(user.name)
      end
    end

    context "名前と年齢が不適切な時" do
      let(:params) { { name: 'test_name', age: user.age } }
      it "ログインできない" do
        post login_path, params: params
        expect(response.body).to match('ログイン')
        expect(response.body).to match('名前')
        expect(response.body).to match('年齢')
      end
    end
  end

  describe "GET /logout" do
    before { login }

    it "ログアウトできる" do
      get logout_path
      expect(response.status).to eq 302
      expect(response).to redirect_to(root_path)

      get users_path
      expect(response.body).to match('ログイン')
    end
  end
end
