class ApplicationController < ActionController::Base
  include Authentication
  # before_action :check_metamask

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def check_metamask
    if cookies[:has_metamask]
      render "metamask/logins/new" unless cookies[:metamask_address]
    end
  end
end
