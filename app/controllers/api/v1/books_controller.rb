class Api::V1::BooksController < ApplicationController

    before_action :authorize_request, only: [:create, :destroy]

    def create

        book = Book.new(book_params)

        if book.save
            render json: {book: book}, status: :created
        else
            render json: {errors: book.errors.full_messages}, status: :unprocessable_entity
        end
    end


    def index
        render json: {books: Book.where(author_id:params[:author_id])}
    end


    def index_all
        render json: {books: Book.all}
    end


    def destroy 

        destroy = Book.find(params[:id]).destroy

        render status: :no_content

    end


    private

    def book_params
        params.require(:book).permit(:title, :author_id)
    end






end
