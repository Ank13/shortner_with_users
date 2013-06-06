get '/' do
  @urls = Url.all
  erb :index
end

# to shorten a URL
post '/urls' do
  short_url = '/' + ((1..9).to_a + ('a'..'h').to_a).sample(6).join # Push to model
  if session[:user_id]
    new_url = Url.create(:long_url => params[:long_url], :short_url => short_url, :clicks => 0, :user_id => session[:user_id])
    @error_message = new_url.errors[:long_url].first
    @urls = Url.all
    @user = User.find(session[:user_id])
    erb :secret
  else
    new_url = Url.create(:long_url => params[:long_url], :short_url => short_url, :clicks => 0)
    @error_message = new_url.errors[:long_url].first
    @urls = Url.all
    erb :index
  end
end

# Change this to be the user's individual page with links 
get '/secret' do
  if session[:user_id] 
      @user = User.find(session[:user_id])
      erb :secret
  else
    redirect '/'
  end
end

#log outs and clears the session from the user's page
get '/logout' do 
  session.clear
  redirect '/'
end

# this brings the user to the URL they want to go to
get '/:short_url' do
  short_url = "/" + params[:short_url]
  url_record = Url.find_by_short_url(short_url)
  counter = url_record.clicks || 0
  new_count = counter + 1
  url_record.update_attributes(clicks: new_count)
  long_url = url_record.long_url
  redirect long_url
end

# creates a new user
post '/create' do
  @user = User.create_user(params[:name], params[:email], params[:password])
  @name = @user.name
  session[:user_id] = @user.id
  erb :secret
end

# logins a user and brings them to their individual page
post '/login' do 
  if User.authenticate?(params[:password], params[:email])
    @user = User.find_by_email(params[:email])
    session[:user_id] = @user.id
    @name = @user.name
    erb :secret
  else
    redirect '/'
  end
end


