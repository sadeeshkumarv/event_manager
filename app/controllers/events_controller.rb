class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:calendar, :edit, :new, :create]

  def calendar
    if params[:u]
      @events = User.find(params[:u]).events
    else
      @events = Event.all
    end
  end
  # GET /events
  # GET /events.json
  def index
    if params[:u]
      @events = User.find(params[:u]).events
    else
      @events = Event.all
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        params[:users].each do |u|
          EventsUser.create!([{ user_id: u.to_i, event_id: @event.id }])
          EventMailer.send_event_email(@event, u).deliver
        end
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      exiting_attendees = @event.users
      if @event.update(event_params)
        (@event.users - exiting_attendees).each do |u|
          EventsUser.create!([{ user_id: u.to_i, event_id: @event.id }])
          # we can consider sending updated event to all users if there is change in schedule
          # we can consider sending event to added users if there is change only in attendees count
          EventMailer.send_update_event_email(@event, u).deliver
        end
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
    def set_user
      @users = User.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :desc, :start_time, :end_time)
    end
end
