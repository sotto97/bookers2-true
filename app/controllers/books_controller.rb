class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :update, :destroy]

  def new
    book = Book.new
  end

  def show
    @book_new = Book.new
    @user = User.find(current_user.id)
  	@book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book_new = Book.new
  end

  def create
    @books = Book.all
  	@book_new = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book_new.user_id = current_user.id
  	if @book_new.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book_new), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
      flash[:notice] = "error"
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

   def baria_user
    @book = Book.find(params[:id])
    unless params[:id].to_i != current_user.id
      redirect_to books_path
    end
   end

end
