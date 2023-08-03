class Api::V1::AuthorsController < ApplicationController

    before_action :authorize_request, only: [:create, :destroy]


    def create
        author = Author.new(author_params)

        if author.save
            render json: {author: author}, status: :created
        else
            render json: {errors: author.errors.full_messages}, status: :unprocessable_entity
        end

    end


    # TODO : améliorer avec de la pagination
    def index
        authors = Author.all 

        render json:{authors:authors}
    end


    def show
        # author = Author.find(params[:id])
        author = Author.find_by(id:params[:id])

        if author
            render json: {author:author}
        else
            render json: {message: "author doesn't exist"}, status: 400
        end

    end



    def destroy 

        destroy = Author.find(params[:id]).destroy

        render status: :no_content

    end




    private 


    def author_params
        params.require(:author).permit(:name, :age)
    end



end
