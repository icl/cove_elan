class WelcomeController < ApplicationController
	before_filter :authenticate_user!

  def index
		@templates_to_review = Template.where(needs_review: true)
    @assets_to_review = UserAsset.where(needs_review: true)
	#	@work_document = WorkDocument.all
		@work_document = WorkDocument.new

		respond_to do |format|
			format.html # index.html.erb
		end
  end

	def new_work_document
	end

	def create_work_document
	end
end
