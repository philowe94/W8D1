class ApplicationController < ActionController::Base

    
    helper_method :current_user, :signed_in?

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def ensure_logged_in
        if !logged_in?
            #redirect to new_session_ur
        end
    end

    def logged_in? 
        !!current_user
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        if logged_in?
            @current_user.reset_session_token!
            session[:session_token] = nil
        end
    end

    def require_signed_in!
        redirect_to new_session_url if logged_in? == false
    end

    def require_moderator
        redirect_to subs_url if moderator? == false
    end
end
