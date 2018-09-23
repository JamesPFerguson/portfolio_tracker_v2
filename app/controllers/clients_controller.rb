class ClientsController < ApplicationController

    def new
        @client = Client.new
    end

    def create
        byebug
        client = Client.new(name: params[:name])
        render json: client
    end

    def index
        
    end

    def update
        
    end

    def destroy
        
    end
end
