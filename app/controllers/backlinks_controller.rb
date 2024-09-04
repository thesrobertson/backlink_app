class BacklinksController < ApplicationController
  before_action :set_backlink, only: %i[ show edit update destroy ]
  before_action :require_admin, except: [:index, :show]

def require_admin
  unless session[:admin]
    redirect_to login_path, alert: "You must be logged in as admin to perform this action"
  end
end

  # GET /backlinks or /backlinks.json
  def index
  @backlinks = Backlink.all
  # Filtering by country
    if params[:country].present?
      @backlinks = @backlinks.where(country: params[:country])
    end

    # Filtering by category
    if params[:category].present?
      @backlinks = @backlinks.where(category: params[:category])
    end

    # Filtering by price range
    if params[:min_price].present?
      @backlinks = @backlinks.where('price >= ?', params[:min_price].to_i)
    end

    if params[:max_price].present?
      @backlinks = @backlinks.where('price <= ?', params[:max_price].to_i)
    end

    # Filtering by article writing (boolean)
    if params[:article_writing].present?
      @backlinks = @backlinks.where(article_writing: params[:article_writing] == 'true')
    end

    # Filtering by CS possible (boolean)
    if params[:cs_possible].present?
      @backlinks = @backlinks.where(cs_possible: params[:cs_possible] == 'true')
    end

    # Filtering by special price (boolean)
    if params[:special_price].present?
      @backlinks = @backlinks.where(special_price: params[:special_price] == 'true')
    end
  # Add more filters as needed
end
  # GET /backlinks/1 or /backlinks/1.json
  def show
  end

  # GET /backlinks/new
  def new
    @backlink = Backlink.new
  end

  # GET /backlinks/1/edit
  def edit
  end

  # POST /backlinks or /backlinks.json
  def create
    @backlink = Backlink.new(backlink_params)

    respond_to do |format|
      if @backlink.save
        format.html { redirect_to backlink_url(@backlink), notice: "Backlink was successfully created." }
        format.json { render :show, status: :created, location: @backlink }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @backlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backlinks/1 or /backlinks/1.json
  def update
    respond_to do |format|
      if @backlink.update(backlink_params)
        format.html { redirect_to admin_dashboard_path, notice: "Backlink was successfully updated." }
        format.json { render :admin_dashboard, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @backlink.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /backlinks/1 or /backlinks/1.json
  def destroy
    @backlink.destroy

    respond_to do |format|
      format.html { redirect_to backlinks_url, notice: "Backlink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
   def set_backlink
    @backlink = Backlink.find(params[:id])
  end

  def backlink_params
    params.require(:backlink).permit(:added_on, :country, :site, :price, :traffic, :domain_rank, :category, :duration, :article_writing, :cs_possible, :special_price, :comments)
  end
end
