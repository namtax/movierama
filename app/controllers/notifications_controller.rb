class NotificationsController < ApplicationController
  def disable 
    current_user.update(notifications: 'false')
  end
end
