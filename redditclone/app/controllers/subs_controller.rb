class SubsController < ApplicationController

    before_action :require_moderator, only [:edit, :update]

    def index
        @subs = Subs.all
        render :index
    end

    def create
        @sub = Sub.new(sub_params)

        if @sub.save!
            redirect_to subs_url
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def new
        @sub = Sub.new
        render :new
    end

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update
        @sub = Sub.find(params[:id])

        if @sub.update_attributes(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end


    private

    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
end