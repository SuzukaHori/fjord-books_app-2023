class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to polymorphic_url([@commentable, @comment]), notice: t('controllers.common.notice_create', name: Comment.model_name.human) 
    else
      redirect_to path, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to polymorphic_url([@commentable, @comment]), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
