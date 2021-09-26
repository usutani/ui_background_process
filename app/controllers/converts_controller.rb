class ConvertsController < ApplicationController
  before_action :set_convert, only: %i[ show edit update destroy ]

  # GET /converts
  def index
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
      redirect_to @convert, notice: "Convert was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /converts/1
  def update
    if @convert.update(convert_params)
      redirect_to @convert, notice: "Convert was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /converts/1
  def destroy
    @convert.destroy
    redirect_to converts_url, notice: "Convert was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_convert
      @convert = Convert.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def convert_params
      params.require(:convert).permit(:status, :message)
    end
end
