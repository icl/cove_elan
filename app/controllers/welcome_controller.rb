
class WelcomeController < ApplicationController
  def index
    @corpora = Corpus.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
