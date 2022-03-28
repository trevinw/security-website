class WorkPermitsController < ApplicationController
  before_action :set_work_permit, only: %i[show edit update destroy]
  before_action :set_work_permits, only: :index
  before_action :set_buildings, only: %i[new edit]
  before_action :set_hazards, only: %i[new edit]
  before_action :set_company_name, only: :index
  before_action :set_companies, only: :index
  before_action :set_active_company_id, only: :index

  def index; end

  def show; end

  def new
    @work_permit = WorkPermit.new
    @companies = Company.all.order(:name)
  end

  def edit
    @companies = Company.all.order(:name)
  end

  def create
    @work_permit = WorkPermit.new(work_permit_params)

    respond_to do |format|
      if @work_permit.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('work_permits', partial: 'work_permit',
                                                                   locals: { work_permit: @work_permit })
        end
        format.html { redirect_to work_permit_path(@work_permit), notice: 'Work Permit successfully created' }
      else
        format.html do
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @work_permit.update(work_permit_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@work_permit, partial: 'work_permits/work_permit',
                                                                  locals: { work_permit: @work_permit })
        end
        format.html { redirect_to work_permit_url(@work_permit), notice: 'Work permit was successfully updated.' }
      else
        render :edit, status: :unprocessable_entity
        # format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_permit.destroy
    # flash.now[:notice] = "#{@work_permit.company.name} permit ##{@work_permit.number} was successfully destroyed."
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@work_permit) }
      format.html { redirect_to work_permits_path }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_work_permit
    @work_permit = WorkPermit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def work_permit_params
    params.require(:work_permit).permit(:number, :company, :status, :work_location, :work_description, :notes,
                                        :start_date, :end_date, :category, :company_id, :needs_bypass,
                                        :seh_representative, :alternative_contact, building_ids: [], hazard_ids: [])
  end

  def set_work_permits
    if params[:company_id] && Company.find(params[:company_id]).work_permits.size.positive?
      @work_permits = WorkPermit.where(company_id: params[:company_id])
                                .order(:number)
                                .includes(:buildings)
                                .includes(:hazards)
    else
      # Query to get first Company sorted by name that has >0 Work Permits belonging to it
      # Query used is modified from stackoverflow link below
      # https://stackoverflow.com/questions/54231074/how-do-i-count-the-number-of-records-that-have-one-or-more-associated-object
      # https://stackoverflow.com/a/39478498/14768757
      company = Company.joins(:work_permits).order(name: :asc).first
      @work_permits = WorkPermit.where(company:)
                                .order(:number)
                                .includes(:buildings)
                                .includes(:hazards)
    end
  end

  def set_buildings
    @buildings = Building.all.order(:number)
  end

  def set_hazards
    @hazards = Hazard.all.order(:name)
  end

  def set_companies
    @companies = Company.joins(:work_permits).order(name: :asc).uniq
  end

  def set_company_name
    return unless params[:company_id]

    @company_name = Company.find(params[:company_id]).name
  end

  def set_active_company_id
    @active_company_id = if params[:company_id]
                           params[:company_id].to_i
                         else
                           Company.joins(:work_permits).order(name: :asc).first.id
                         end
  end
end
