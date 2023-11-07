RSpec.describe "/users", type: :request do
  let(:tel) { '080-0000-0000' }
  let(:address) { '東京都渋谷区' }
  let(:body) { response.body }

  describe "POST /create" do
    context "パラメーターが適切な時" do
      let(:attributes) { attributes_for(:user, age: 20, tel: tel, address: address) }

      it "ユーザーが作成される" do
        expect {
          post users_url, params: { user: attributes }
        }.to change(User, :count).by(1)

        user = User.last
        expect(user.tel).to eq(tel)
        expect(user.address).to eq(address)
      end
    end

    context "nameとageが空の時" do
      let(:attributes) { attributes_for(:user, name: nil, age: nil) }

      it "userオブジェクトにnameとageのバリデーションエラーが追加される" do
        expect {
          post users_url, params: { user: attributes }
        }.to change(User, :count).by(0)

        user = controller.instance_variable_get("@user")
        expect(user.errors[:name]).to be_present
        expect(user.errors[:age]).to be_present
      end
    end

    context "ageが数字じゃない時" do
      let(:attributes) { attributes_for(:user, age: '二十') }

      it "userオブジェクトにageのバリデーションエラーが追加される" do
        expect {
          post users_url, params: { user: attributes }
        }.to change(User, :count).by(0)

        user = controller.instance_variable_get("@user")
        expect(user.errors[:age]).to eq(['is not a number'])
      end
    end
  end
end
