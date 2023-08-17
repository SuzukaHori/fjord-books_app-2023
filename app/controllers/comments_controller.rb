class CommentsController < ApplicationController

   def create
      @comment = @commentable.comments.build(comment_params)
      @comment.user_id = current_user.id
      path = 
      if @commentable.is_a?(Report)
         report_path(@commentable)
      elsif @commentable.is_a?(Book)
         book_path(@commentable)
      else
         root_path
      end

      if @comment.save
         redirect_to path, notice: 'Comment was successfully created.'
      else
         redirect_to path, alert: 'Bad'
      end
   end

   private
   def comment_params
      params.require(:comment).permit(:content)
   end
end
