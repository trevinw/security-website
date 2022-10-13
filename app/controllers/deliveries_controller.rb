class DeliveriesController < ApplicationController
  before_action :set_delivery, only: %i[show edit update destroy]
  before_action :set_users, only: %i[index new edit]
  before_action :set_datetime_time_zone, only: :create

  def index
    start_date = if params[:start_date].present?
                   params[:start_date].in_time_zone('Pacific Time (US & Canada)').midnight
                 else
                   DateTime.now.midnight.to_time
                 end
    end_date = if params[:end_date].present?
                 params[:end_date].in_time_zone('Pacific Time (US & Canada)').end_of_day
               else
                 DateTime.now.end_of_day.to_time
               end
    @date_string = if params[:start_date]
                     "Deliveries from #{start_date.strftime('%m/%d/%y')} - #{end_date.strftime('%m/%d/%y')}"
                   else
                     "Deliveries for #{DateTime.now.strftime('%m/%d/%y')}"
                   end

    @deliveries = Delivery.where(datetime: start_date..end_date).order(datetime: :desc)
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

  def set_datetime_time_zone
    return unless params[:delivery][:datetime].present?

    params[:delivery][:datetime] = params[:delivery][:datetime].in_time_zone('Pacific Time (US & Canada)')
  end

  def delivery_params
    params.require(:delivery).permit(:datetime, :company, :category, :destination, :chemical_delivery,
                                     :chemical_type, :seh_contact, :notes, :user_id)
  end
end
