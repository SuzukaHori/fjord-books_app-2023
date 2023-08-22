class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    path = set_each_path(@commentable)

    if @comment.save
      redirect_to path, notice: t('controllers.common.notice_create', name: Comment.model_name.human) 
    else
      redirect_to path, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    path = set_each_path(@commentable)
    redirect_to path, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_each_path(commentable) #TODO:リファクタリング
   if commentable.is_a?(Report)
     report_path(commentable)
   elsif commentable.is_a?(Book)
     book_path(commentable)
   else
     root_path
   end
  end
end
