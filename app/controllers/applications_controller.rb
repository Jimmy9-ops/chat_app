# app/controllers/applications_controller.rb
class ApplicationsController < ApplicationController

   before_action :set_application, only: [:show, :update]


     # PATCH/PUT /applications/:token
    def update
     if @application.update(application_params)
      render json: @application
     else
      render json: @application.errors, status: :unprocessable_entity
      end
    end

    def create
      @application = Application.new(application_params)
      if @application.save
        render json: @application, status: :created
      else
        render json: @application.errors, status: :unprocessable_entity
      end
    end

    # GET /applications/:id
  def show
    render json: @application
  end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_application
    @application = Application.find_by(token: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Application not found' }, status: :not_found
  end

   # Only allow a trusted parameter "white list" through.
   def application_params
    params.require(:application).permit(:name)
  end
end
