class CommentsController < ApplicationController  
  before_action :authenticate_user!, only: [:create]

  def create
    @gram = Gram.find_by_id(params[:gram_id])
    return render_not_found if @gram.blank?
    @gram.comments.create(comment_params.merge(user: current_user))
    if @gram.invalid?
      flash[:alert] = 'Comment must be between 5-100 characters'
    end
    redirect_to gram_path(@gram)
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
