RSpec.describe "/tasks", type: :request do
  let(:valid_attributes) {
    attributes_for(:task)
  }

  let!(:task) { create(:task, valid_attributes) }
  let(:body) { response.body }

  describe "サイドバーに" do
    it "タスクへのリンクがある" do
      get root_url
      expect(response).to be_successful
      expect(body).to match('タスク')
    end
  end

  describe "タスク一覧ページ（GET /tasks）" do
    it "適切な日本語表記ができている" do
      get tasks_url
      expect(response).to be_successful
      expect(body).to match(task.title)
      expect(body).to match('タイトル')
      expect(body).to match('タスク一覧')
    end
  end

  describe "タスク詳細ページ（GET /tasks/{id}）" do
    it "適切な日本語表記ができている" do
      get task_url(task)
      expect(response).to be_successful
      expect(body).to match('タイトル')
      expect(body).to match('内容')
      expect(body).to match('編集')
      expect(body).to match('一覧')
      expect(body).to match('削除')
    end
  end

  describe "タスク新規作成ページ（GET /tasks/new）" do
    it "適切な日本語表記ができている" do
      get new_task_url
      expect(response).to be_successful
      expect(body).to match('タイトル')
      expect(body).to match('内容')
      expect(body).to match('一覧')
      expect(body).to match('登録')
    end
  end

  describe "タスク新規作成ページ（GET /tasks/{id}/edit）" do
    it "適切な日本語表記ができている" do
      get edit_task_url(task)
      expect(response).to be_successful

      expect(body).to match('タイトル')
      expect(body).to match('内容')
      expect(body).to match('一覧')
      expect(body).to match('登録')
    end
  end

  describe "POST /create" do
    context "パラメーターが適切な時" do
      it "タスクが作成される" do
        expect {
          post tasks_url, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "フラッシュメッセージが日本語で表示される" do
        post tasks_url, params: { task: valid_attributes }
        expect(response).to redirect_to(task_url(Task.last))
        expect(flash[:notice]).to eq "タスクの新規登録に成功しました"
      end
    end
  end

  describe "PATCH /update" do
    context "パラメーターが適切な時" do
      let(:new_title) { 'Newらんてくん' }
      let(:new_attributes) { attributes_for(:task, title: new_title) }

      it "タスクのtitleを更新する" do
        patch task_url(task), params: { task: new_attributes }
        task.reload
        expect(task.title).to eq(new_title)
        expect(response).to redirect_to(task_url(task))
        expect(flash[:notice]).to eq "タスクの更新に成功しました"
      end
    end
  end

  describe "DELETE /destroy" do
    it "タスクを削除する" do
      expect {
        delete task_url(task)
      }.to change(Task, :count).by(-1)
    end

    it "タスク一覧へリダイレクトされる" do
      delete task_url(task)
      expect(response).to redirect_to(tasks_url)
    end
  end
end
