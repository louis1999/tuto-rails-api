class ApplicationController < ActionController::API



    def ping
        render json: {response: "pong"}
    end




    # verifier que le token est valide et que le user existe
    def authorize_request
        header = request.headers["Authorization"]
        token = header.split(' ')[1] if header
        begin
            decoded = JWT.decode(token, ENV["JWT_SECRET"])
            @current_user = User.find(decoded[0]["sub"])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end

    
end
