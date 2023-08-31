# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to polymorphic_url([@commentable, @comment]), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to polymorphic_url([@commentable, @comment]), status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to polymorphic_url([@commentable, @comment]), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end
