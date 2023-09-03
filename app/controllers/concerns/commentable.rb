# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    before_action :set_comment, only: %i[destroy]
  end

  def create
    @comment = @commentable.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to polymorphic_url([@commentable, @comment]), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to polymorphic_url([@commentable, @comment]), status: :unprocessable_entity
    end
  end

  def destroy
    current_user.comments.find(params[:id]).destroy!
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
