class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(params[user_id:current_user]).all
  end

  def show
    @reservation = Reservation.find_by(id: params[:id])
  end

  def new
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:room_id])
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @guests = params[:guests]
    if @reservation.invalid?
      @error_messages = @reservation.errors.full_messages
      render template: "rooms/show"
    else
      @user = current_user
      @reservation.total_days = @reservation.amount_days
      @reservation.total_price = @reservation.amount_price
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約完了しました"
      redirect_to room_reservation_path(@room.id,@reservation)
    else
      render :new
    end
  end


  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約を削除しました"
    redirect_to :reservations
  end

  private
    def reservation_params
      params.require(:reservation).permit(:start_date,:end_date,:guests,:total_days,:total_price).merge(user_id: current_user.id, room_id: params[:room_id])
    end

end
