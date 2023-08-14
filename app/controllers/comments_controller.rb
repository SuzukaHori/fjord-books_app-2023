class CommentsController < ApplicationController
   def create
      @comment = @commentable.comments.build(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
         redirect_to reports_path, notice: 'Comment was successfully created.'
      else
         render :new, status: :unprocessable_entity
      end
   end

   private
   def comment_params
      params.require(:comment).permit(:content)
   end
end
