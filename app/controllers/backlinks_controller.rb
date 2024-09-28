class BacklinksController < ApplicationController
  before_action :set_backlink, only: %i[ show edit update destroy ]
  before_action :hide_cat_col
 

def require_admin
  unless session[:admin]
    redirect_to login_path, alert: "You must be logged in as admin to perform this action"
  end
end

  # GET /backlinks or /backlinks.json
  def index
  @backlinks = Backlink.all
  @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
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
        format.html { redirect_to new_backlink_url, notice: "Backlink was successfully created." }
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

   def home
    @backlinks_by_country = Backlink.all.group_by(&:country)
  end


  # DELETE /backlinks/1 or /backlinks/1.json
  def destroy
    @backlink.destroy

    respond_to do |format|
      format.html { redirect_to backlinks_url, notice: "Backlink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def by_country
    # Find backlinks based on the selected country passed as a parameter

    if params[:country].present?
      @backlinks = Backlink.where(country: params[:country])
       @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
    else
      @backlinks = Backlink.all # Fallback to all backlinks if no country is selected
       @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
    end
  end

   def by_new
    # Calculate the date range for the last 4 months
    four_months_ago = 4.months.ago.to_date

    # If the :country param is provided, filter by country and the added_on date
    if params[:country].present?
      @backlinks = Backlink.where('added_on >= ?', four_months_ago)
                           .where(country: params[:country])
                           .order(added_on: :desc)
                            @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
    else
      # If no country is provided, just filter by the added_on date
      @backlinks = Backlink.where('added_on >= ?', four_months_ago)
                           .order(added_on: :desc)
                            @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
    end
  end


  def by_special
    # Find backlinks based on the selected country passed as a parameter
    if params[:country].present?
      @backlinks = Backlink.where(special_price: true)
                           .where(country: params[:country])
                           .order(added_on: :desc)
                            @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
    else
      # If no country is provided, just filter by the added_on date
      @backlinks = Backlink.where(special_price: true)
                           .order(added_on: :desc)
                            @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
    end
  end


  def by_category
    # Find backlinks based on the selected country passed as a parameter
    if params[:category].present?
      @backlinks = Backlink.where(category: params[:category])
       @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
       @hide_col = true
    else
      @backlinks = Backlink.all # Fallback to all backlinks if no country is selecte
       @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
    end
  end

  def recently_deleted
   @backlinks = Backlink.where(available: false).order(updated_at: :desc)
  end


  private

   def set_backlink
    @backlink = Backlink.find(params[:id])
  end

  def backlink_params
    params.require(:backlink).permit(:added_on, :country, :site, :price, :traffic, :domain_rank, :category, :duration, :article_writing, :cs_possible, :special_price, :comments)
  end

  def assign_colors(categories)
    colors = [
      "#264653", "#2A9D8F", "#E76F51", "#1D3557", "#457B9D",
      "#2B2D42", "#8D99AE", "#D90429", "#3A0CA3", "#7209B7",
      "#3F37C9", "#4A4E69", "#22223B", "#9A031E", "#5A189A",
      "#023047", "#FF006E", "#3A506B", "#1B263B", "#0D3B66",
      "#144552", "#003566", "#001D3D", "#004B23", "#2D6A4F",
      "#606C38", "#283618", "#102027", "#232931", "#393E46"
    ]

    # Create a hash with categories as keys and colors as values
    categories.each_with_index.with_object({}) do |(category, index), hash|
      hash[category] = colors[index % colors.length]
    end
  end
  def hide_cat_col
    @hide_col = false
  end
end
