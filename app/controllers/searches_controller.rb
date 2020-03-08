class SearchesController < ApplicationController
  def search
  	# viewのformで取得したパラメータをモデルに渡す。
  	@books = Book.search(params[:search])
  	@users = User.search(params[:search])
  	@search = params[:search]
  end
  def index
  	# @books = Book.search(params[:search])
  	@search = params[:search]
  	@users = User.search(params[:search])
  end
end
