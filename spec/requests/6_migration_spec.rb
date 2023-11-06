RSpec.describe "/users", type: :request do
  let(:tel) { '080-0000-0000' }
  let(:address) { '東京都渋谷区' }
  let(:valid_attributes) { attributes_for(:user, age: 20, tel: tel, address: address) }
  let!(:user) { create(:user, valid_attributes) }
  let(:body) { response.body }

  describe "ユーザー一覧ページ（GET /users）" do
    it "適切な日本語表記ができている" do
      get users_url
      expect(response).to be_successful
      expect(body).to match(user.tel)
      expect(body).to match(user.address)
      expect(body).to match('名前')
      expect(body).to match('年齢')
      expect(body).to match('電話番号')
      expect(body).to match('住所')
    end
  end

  describe "ユーザー詳細ページ（GET /users/{id}）" do
    it "適切な日本語表記ができている" do
      get user_url(user)
      expect(response).to be_successful
      expect(body).to match('名前')
      expect(body).to match('年齢')
      expect(body).to match('電話番号')
      expect(body).to match('住所')
      expect(body).to match('編集')
      expect(body).to match('一覧')
      expect(body).to match('削除')

      expect(body).to match(user.name)
      expect(body).to match(user.age.to_s)
      expect(body).to match(user.tel)
      expect(body).to match(user.address)
    end
  end

  describe "ユーザー新規作成ページ（GET /users/new）" do
    it "適切な日本語表記ができている" do
      get new_user_url
      expect(response).to be_successful
      expect(body).to match('名前')
      expect(body).to match('年齢')
      expect(body).to match('電話番号')
      expect(body).to match('住所')
      expect(body).to match('一覧')
      expect(body).to match('登録')
    end
  end

  describe "ユーザー編集ページ（GET /users/{id}/edit）" do
    it "適切な日本語表記ができている" do
      get edit_user_url(user)
      expect(response).to be_successful

      expect(body).to match('名前')
      expect(body).to match('年齢')
      expect(body).to match('一覧')
      expect(body).to match('登録')
    end
  end

  describe "POST /create" do
    context "パラメーターが適切な時" do
      it "ユーザーが作成される" do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)

        user = User.last
        expect(user.tel).to eq(tel)
        expect(user.address).to eq(address)
      end
    end
  end

  describe "PATCH /update" do
    context "パラメーターが適切な時" do
      let(:new_tel) { '090-0000-0000' }
      let(:new_address) { '東京都渋谷区宇田川町' }
      let(:new_attributes) { attributes_for(:user, tel: new_tel, address: new_address) }

      it "ユーザーのnameを更新する" do
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.tel).to eq(new_tel)
        expect(user.address).to eq(new_address)
        expect(response).to redirect_to(user_url(user))
        expect(flash[:notice]).to eq "ユーザーの更新に成功しました"
      end
    end
  end
end
