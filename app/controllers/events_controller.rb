class EventsController < ApplicationController
    before_action :authenticate_user!, except: [:index]

    def index
        @events = Event.all
        if user_signed_in?
            @event = current_user.organized_events.build
        end
    end

    def new
        @event = current_user.organized_events.build
    end

    def show
        @event = Event.find(params[:id])
    end

    def create
        @event = current_user.organized_events.build(event_params)

        respond_to do |format|
            if @event.save
              format.html { redirect_to root_path, notice: "Event successfully created." }
              format.json { render :index, status: :created, location: @event }
            else
              @events = Event.all
              format.html { render :index, status: :unprocessable_entity, :locals => {:events => @events}}
              format.json { render json: @event.errors, status: :unprocessable_entity }
            end
          end
    end

    private
    def event_params
        params.require(:event).permit(:location, :date)
    end

end