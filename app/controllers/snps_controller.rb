class SnpsController < ApplicationController
  before_action :set_snp, only: [:show]
  
  def show
    respond_to do |format|

      format.html {}

      format.json {
        render json: {
            snp: {
                sources: @snp.sources,
                diseases: @snp.diseases.as_json({summarize: true})
            }
        }
      }

    end
  end

  private

  def set_snp
    @snp = Snp.find_by!(rsid: params[:rsid])
  end
end
