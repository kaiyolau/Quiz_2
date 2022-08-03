class ReviewsController < ApplicationController
  before_action :find_idea
  before_action :authenticate_user!


  def create
    @review = Review.new(params.require(:review).permit(:body))
    @review.idea = @idea
    @review.user = current_user
    if @review.save
      # ReviewMailer.new_review(@review).deliver_later
      redirect_to idea_path(@idea), notice: "Review created!"
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      render '/ideas/show', status: 303
    end
  end

  def destroy
    @review = Review.find params[:id]
    if can?(:crud, @review)
      @review.destroy
      redirect_to idea_path(@idea), notice: "Review deleted"
    else
      redirect_to root_path, alert: "Not authorized"
    end
  end

  private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end


end
