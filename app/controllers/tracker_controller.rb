class TrackerController < ApplicationController
  before_action :reqlogin, except: [:login, :register, :dologin, :doregister]
  def login
  end

  def register
  end

  def dologin
    targ = User.find_by username: params[:username]
    if targ.authenticate(params[:password])
      session[:id] = targ.id
      redirect_to dashboard_path
    else
      redirect_to "/"
    end
  end

  def doregister
    nu = User.new(user_params)
    if nu.save
      session[:id] = User.last.id
      redirect_to dashboard_path
    else
      flash[:errors] = nu.errors.messages
      redirect_to "/register"
    end
  end
  def dologout
    session.clear
    redirect_to '/'
  end
  def dodestroy
    User.find(session[:id]).destroy
  end
  

  def dmview
    @cuser = User.find(session[:id])
    @camp = Campaign.find(params[:cid])
    unless @camp.ownedby?(@cuser)
      flash[:errors] = 'You don\'t own that campaign'
      redirect_to dashboard_path
    end
  end

  def playerview
    @cuser = User.find(session[:id])
    @targpc = Pc.find(params[:pcid])
    @camp = @targpc.campaign
  end

  def dashboard
    @cuser = User.find(session[:id])
  end
  def campaign
    @cuser = User.find(session[:id])
  end
  def newcampaign
    ncamp = Campaign.new(campaign_params)
    ncamp.save
    redirect_to dashboard_path
  end
  def pc
    @cuser = User.find(session[:id])
  end
  def newpc
    pc = Pc.new(pc_params)
    pc.save
    redirect_to playerview_path(Pc.last.id)
  end



  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
  def campaign_params
    params.require(:campaign).permit(:title, :password_digest).merge(user: User.find(session[:id]))
    # password_digest field since the join code was set up with bcrypt before i realized the salt would make it inefficient
  end
  def pc_params
    params.require(:pc).permit(:name).merge(user: User.find(session[:id]), campaign: Campaign.find_by(password_digest: params[:code]))
    # password_digest field since the join code was set up with bcrypt before i realized the salt would make it inefficient
  end
  def reqlogin
    unless session[:id]
      flash[:errors] = 'you must be logged in'
      redirect_to '/'
    end
  end
end
