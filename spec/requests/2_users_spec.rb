RSpec.describe "/users", type: :request do
  let(:valid_attributes) {
    attributes_for(:user)
  }

  let!(:user) { create(:user, valid_attributes) }
  let(:body) { response.body }

  describe "ユーザー一覧ページ（GET /users）" do
    it "適切な日本語表記ができている" do
      get users_url
      expect(response).to be_successful
      expect(body).to match(user.name)
      expect(body).to match('名前')
      expect(body).to match('ユーザー一覧')
    end
  end

  describe "ユーザー詳細ページ（GET /users/{id}）" do
    it "適切な日本語表記ができている" do
      get user_url(user)
      expect(response).to be_successful
      expect(body).to match('名前')
      expect(body).to match('年齢')
      expect(body).to match('編集')
      expect(body).to match('一覧')
      expect(body).to match('削除')
    end
  end

  describe "ユーザー新規作成ページ（GET /users/new）" do
    it "適切な日本語表記ができている" do
      get new_user_url
      expect(response).to be_successful
      expect(body).to match('名前')
      expect(body).to match('年齢')
      expect(body).to match('一覧')
      expect(body).to match('登録')
    end
  end

  describe "ユーザー新規作成ページ（GET /users/{id}/edit）" do
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
      end

      it "フラッシュメッセージが日本語で表示される" do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(user_url(User.last))
        expect(flash[:notice]).to eq "ユーザーの新規登録に成功しました"
      end
    end
  end

  describe "PATCH /update" do
    context "パラメーターが適切な時" do
      let(:new_name) { 'Newらんてくん' }
      let(:new_attributes) { attributes_for(:user, name: new_name) }

      it "ユーザーのnameを更新する" do
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(user.name).to eq(new_name)
        expect(response).to redirect_to(user_url(user))
        expect(flash[:notice]).to eq "ユーザーの更新に成功しました"
      end
    end
  end

  describe "DELETE /destroy" do
    it "ユーザーを削除する" do
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "ユーザー一覧へリダイレクトされる" do
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
