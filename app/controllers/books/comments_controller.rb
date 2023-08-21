class Books::CommentsController < CommentsController
  before_action :set_commentable, only: [:create, :destroy]

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
