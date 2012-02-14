
class WelcomeController < ApplicationController
	before_filter :authenticate_user!

  def index
		@corpora = Corpus.all
		@user = User.find(current_user.id)

		respond_to do |format|
			format.html # index.html.erb
		end
  end
end
