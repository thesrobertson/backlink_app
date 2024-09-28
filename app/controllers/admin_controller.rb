class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
    @backlinks = Backlink.all
    @category_colors = assign_colors(@backlinks.pluck(:category).uniq.compact)
  end

  private

  def require_admin
    unless session[:admin]
      redirect_to login_path, alert: "You must be logged in as admin to access this page."
    end
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

  # Create a hash mapping categories to colors, cycling colors if there are more categories than colors
  categories.each_with_index.with_object(Hash.new(colors.first)) do |(category, index), hash|
    hash[category] = colors[index % colors.length]
  end
end
end
