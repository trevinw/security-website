class DeliveriesController < ApplicationController
  before_action :set_delivery, only: %i[show edit update destroy]
  before_action :set_users, only: %i[index new edit]

  def index
    if params[:start_date] && params[:end_date]
      start_date = DateTime.parse(params[:start_date])
      begin
        end_date = DateTime.parse(params[:end_date])
      rescue ArgumentError => _e
        end_date = DateTime.current.in_time_zone('Pacific Time (US & Canada)').end_of_day
      end
      @deliveries = Delivery.where(datetime: start_date..end_date)
      @date_string = "Deliveries from #{start_date.strftime('%m/%d/%y')} - #{end_date.strftime('%m/%d/%y')}"
    else
      @deliveries = Delivery.where(datetime: DateTime.now.midnight).order(datetime: :desc)
      @date_string = "Deliveries for #{DateTime.now.strftime('%m/%d/%y')}"
    end

    @delivery = Delivery.new
  end

  def show; end

  def new
    @delivery = Delivery.new
  end

  def edit; end

  def create
    @delivery = Delivery.new(delivery_params)

    if @delivery.save
      redirect_to deliveries_path, notice: 'Delivery successfully created'
    else
      render :index, status: :unprocessable_entity, alert: 'Error creating Delivery'
    end
  end

  def update
    if @delivery.update(delivery_params)
      redirect_to deliveries_path, notice: 'Delivery successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @delivery.destroy

    redirect_to deliveries_path, notice: 'Delivery successfully deleted'
  end

  private

  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

  def set_users
    @users = User.active.with_any_role(:admin, :security_lead, :security_rover).sort_by(&:badge)
  end

  def delivery_params
    params.require(:delivery).permit(:datetime, :company, :category, :destination, :chemical_delivery,
                                     :chemical_type, :seh_contact, :notes, :user_id)
  end
end
