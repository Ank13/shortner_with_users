get '/' do
  @urls = Url.all
  erb :index
end

post '/urls' do
  short_url = '/' + ((1..9).to_a + ('a'..'h').to_a).sample(6).join # Push to model
  new_url = Url.create(:long_url => params[:long_url], :short_url => short_url, :clicks => 0)
  @error_message = new_url.errors[:long_url].first
  @urls = Url.all
  erb :index
end

# e.g., /q6bda
get '/:short_url' do
  short_url = "/" + params[:short_url]
  url_record = Url.find_by_short_url(short_url)
  counter = url_record.clicks || 0
  new_count = counter + 1
  url_record.update_attributes(clicks: new_count)
  long_url = url_record.long_url
  redirect long_url
end
