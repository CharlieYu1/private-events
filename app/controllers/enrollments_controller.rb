class EnrollmentsController < ApplicationController
    before_action :authenticate_user!
    def create
        event = Event.find(params[:event_id])
        enrollment = current_user.enrollments.build(event_id: event.id)
        respond_to do |format|
            if enrollment.save
              format.html { redirect_to event_path(event.id), notice: "Sucessfully enrolled." }
              format.json { render :index, status: :created, location: @event }
            else
              @events = Event.all
              format.html { render :index, status: :unprocessable_entity, :locals => {:events => @events}}
              format.json { render json: @event.errors, status: :unprocessable_entity }
            end
        end
    end
    def destroy
        enrollment = Enrollment.find(params[:id])
        event = enrollment.event
        if enrollment.user == current_user
            respond_to do |format|
                if enrollment.destroy
                  format.html { redirect_to event_path(event.id), notice: "Sucessfully cancelled enrollment." }
                  format.json { render :index, status: :created, location: @event }
                else
                  @events = Event.all
                  format.html { render :index, status: :unprocessable_entity, :locals => {:events => @events}}
                  format.json { render json: @event.errors, status: :unprocessable_entity }
                end
            end
        else
            redirect_to event_path(event.id)
        end
    end    
end