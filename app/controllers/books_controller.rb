class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :login_check
    before_action :correct_user?, only: [:edit, :update]
    
    
    # Create Book buttonをクリック時のBook生成のアクション
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            redirect_to book_path(@book)
            flash[:notice] = "You have creatad book successfully."
        else
            @user = current_user
            @books = Book.all
            @users = User.all
            render :index
        end
    end
    # Book クリック時の (URL：/books) の表示のアクション
    def index
        @users = User.all
        @user = current_user
        @book = Book.new
        @books = Book.all
    end
    # index 画面の title をクリックして、Book Detail 表示時のアクション
    def show
        @book = Book.new
        @books = Book.find(params[:id])
        @user = @books.user
    end

    def edit
        @book = Book.find(params[:id])
    end
    
    def update
        @book = Book.find(params[:id])
        @book.update(book_params)
        if @book.save
            redirect_to book_path(@book.id)
            flash[:notice] = "You have updated book successfully."
        else
            render :edit
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    private
    def book_params
        params.require(:book).permit(:title, :body)
    end

    def login_check
        unless user_signed_in?
            flash[:alert] = "You need to sign in or sign up before continuing."
            redirect_to new_user_session_path
        end
    end

    def correct_user?
        book = Book.find(params[:id])
        @book_user_id = current_user.id
        @access_user_id = book.user_id
        p @book_user_id
        p @access_user_id
        unless @book_user_id == @access_user_id
            redirect_to books_path
        end
    end    
end
