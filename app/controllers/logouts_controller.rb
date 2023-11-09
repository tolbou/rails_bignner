class LogoutsController < ApplicationController
    def show
        # セッションからユーザーidを削除する
        session.delete(:user_id)
        # メモ化された現在のユーザーをクリアする
        @_current_user = nil
        redirect_to root_path
    end

end