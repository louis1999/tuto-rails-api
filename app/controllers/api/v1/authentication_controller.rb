class Api::V1::AuthenticationController < ApplicationController


    def login

        # if password correct

        user = User.where(email:authentication_params[:email])
        if(user.length==1)
            user = user[0]
            if user.authenticate(authentication_params[:password])
                exp = 172800 # 2 days
                # TODO : on peut ajouter un attribut "remember_me"
                token = JWT.encode({
                    sub: user.id,
                    exp: Time.now.to_i + exp
                }, ENV["JWT_SECRET"], 'HS256')
                render json: {user:user, token:token}
            else
                render json: {error: "Credentials incorrect"}
            end

        else
            render json: {error: "Credentials incorrect"}
        end

        # return authentication token

    end


    private

    def authentication_params
        params.require(:authentication).permit(:email, :password)
    end




end
