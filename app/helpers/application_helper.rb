
	module ApplicationHelper
  def clean_url(url)
    # Step 1: Remove 'http://', 'https://', 'www.' from the beginning
    cleaned_url = url.sub(/\Ahttps?:\/\/(www\.)?/, '')

    # Step 2: Remove everything after the domain (e.g., paths like '/index.html', '/en')
    cleaned_url = cleaned_url.split('/').first

    # Step 3: Limit the URL to 25 characters and add ellipsis if necessary
    cleaned_url.length > 25 ? cleaned_url[0...25] + '...' : cleaned_url
  end
end

