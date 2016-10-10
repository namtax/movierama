class NotificationsController < ApplicationController
  def disable 
    if current_user
      current_user.update(notifications: 'false')
    else
      redirect_to root_url
    end
  end
end
