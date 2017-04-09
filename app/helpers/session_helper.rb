module SessionHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_name] = user.name
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    @current_user ||= AdminUser.find_by(name: session[:user_name])
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_name)
    @current_user = nil
  end
end
