class AgreementController < ApplicationController
  def index
    
    year_ini = params[:year_ini].to_i
    year_end = params[:year_end].to_i
    year_ini = 2008 if (year_ini < 2008)
    year_end = 2013 if (year_end < 2008)

    
    year_ini = Date.new(year_ini, 1, 1)
    year_end = Date.new(year_end, 12, 31)

    case params[:type]
    when "amount"
      order_by = "total_amount"
    when "entities"
      order_by = "number_of_signatories"
    when "percentage"
      order_by = "dga_contribution_percentage"
    else
      order_by = "id"
    end
    title = params[:title]? "%#{params[:title]}%": "%"
    signatories = params[:signatories]? "%#{params[:signatories]}%": "%"
    @agreements = Agreement.where(:agreement_date => year_ini..year_end)
      .where("lower(title) like lower(?)", title)
      .where("lower(signatories) like lower(?)", signatories)
      .order("#{order_by} DESC")
    @paginated_agreements = @agreements.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @agreement = Agreement.find params[:id]
  end

  def search
    render json: Signatories.instance.find(params[:term])
  end
end
