class SessionsController < ApplicationController
  #salesforce ログインのコールバック
  def callback
    renter text: auth
    auth = request.env["omniauth.auth"]
    user = Account.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    #render text:auth["credentials"]["token"]

    session[:token] = auth["credentials"]["token"]
    session[:user_id] = user.id
    session[:img] = auth["info"]["image"].to_s

  #  render text:session[:img].to_s
    redirect_to root_path, :notice => 'Welcome to Salesforce!!'
  end

  #facebook ログインのコールバック
  def create
    account = Account.from_omniauth(env["omniauth.auth"])
    session[:account_id] = account.id
    redirect_to root_path, :notice => 'Facebookでサインインしました'
    #render text: account.to_json
  end

  def destroy
    session[:account_id] = nil
    reset_session
    redirect_to root_path, :notice => ' サインアウトしました'
  end

  def oauth_failure
    redirect_to root_path, :notice => ' サインイン処理が中断されました'
  end

end

