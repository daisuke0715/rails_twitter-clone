class BooksController < ApplicationController
    # Create Book buttonをクリック時のBook生成のアクション
    def create
        book = Book.new(book_params)
        book.user_id = current_user.id
        if book.save
            redirect_to book_path(book.id)
            flash[:notice] = "You have creatad book successfully."
        else
            @user = User.find(current_user.id)
            @book = Book.new
            @users = User.all
            @books = Book.all
            render "index"
        end
    end
    # Book クリック時の (URL：/books) の表示のアクション
    def index
        @users = User.all
        @user = User.find(current_user.id)
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
        book = Book.find(params[:id])
        book.update(book_params)
        if book.save
            redirect_to book_path(book.id)
            flash[:notice] = "You have updated book successfully."
        else
            render "edit"
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
end
