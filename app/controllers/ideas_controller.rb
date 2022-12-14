class IdeasController < ApplicationController


  # =============CALLBACKS=====================
  before_action :find_idea, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only:[:edit, :update, :destroy]


#=========create ============
  def new
      @idea = Idea.new
  end

  def create
      @idea = Idea.new(idea_params)
      @idea.user = current_user
      if @idea.save
          flash[:notice]= "Idea created sucessfully!"  #-->flash notice
          redirect_to idea_path(@idea)
      else
          render :new
      end
  end
#=================read==============
  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def show
    @reviews = @idea.reviews.order(created_at: :desc)
    @review = Review.new
    @like = @idea.likes.find_by(user: current_user)
  end
#========================update==========================
  def edit
  end

  def update
      if @idea.update(idea_params)
          redirect_to idea_path(@idea)
      else
          render :edit
      end
  end
#=================delete========================
  def destroy
      @idea.destroy
      redirect_to ideas_path
  end






  private

  def authorize_user!
    redirect_to root_path, alert: "Not authorized" unless can?(:crud, @idea)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end



end
