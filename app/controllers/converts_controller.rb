class ConvertsController < ApplicationController
  before_action :set_convert, only: [:show, :edit, :update, :destroy]

  # GET /converts
  def index
    @need_to_reload = Convert.need_to_reload?
    @convert = Convert.new
    @converts = Convert.all
  end

  # GET /converts/1
  def show
  end

  # GET /converts/new
  def new
    @convert = Convert.new
  end

  # GET /converts/1/edit
  def edit
  end

  # POST /converts
  def create
    @convert = Convert.new(convert_params)

    if @convert.save
      FileConvertJob.perform_later(@convert)
      @new_convert = Convert.new
      @notice = 'Convert was successfully created.'
    else
      @need_to_reload = Convert.need_to_reload?
      @converts = Convert.all
      render :index, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /converts/1
  def update
    if @convert.update(convert_params)
      redirect_to @convert, notice: 'Convert was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /converts/1
  def destroy
    @convert.destroy
    redirect_to converts_url, notice: 'Convert was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_convert
      @convert = Convert.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def convert_params
      params.require(:convert).permit(:in_file)
    rescue ActionController::ParameterMissing
      nil
    end
end
