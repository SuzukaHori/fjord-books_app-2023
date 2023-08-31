# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  include Commentable
  before_action :set_commentable
  before_action :set_comment, only: %i[destroy]

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
