require 'sinatra'
require_relative "lib/hangman.rb"

enable :sessions

get '/' do

	session[:game] = Game.new if session[:game].nil?

	if params["letter"] != nil
	     session[:game].check(params["letter"])
	end

	if params[:restart] == "true"
	     session[:game] = Game.new
	end

	erb :index, :locals => {:lives => session[:game].lives_left,
		     	 		   :chosen_letters => session[:game].chosen_letters,
		     	 		   :guessing => session[:game].display_word,
		     	 		   :message => session[:game].status,
		     	 		   :input_status => session[:game].input_status
						  }
end