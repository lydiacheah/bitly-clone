get '/' do
  @urls = Url.all
  erb :"static/index"
end
 
post '/submit' do
  @urls = Url.find_by(long_url: params[:long_url])
  
  if Url.exists?(long_url: params[:long_url])
    return @urls.to_json
  else
    @url = Url.new(long_url: params[:long_url])
    if @url.save
      return @url.to_json
    else
      @errors = {errors: @url.errors}
      return @errors.to_json
    end
  end
end
 
get '/error' do
  erb :"static/error"
end
  
get '/:short_url' do
  @url = Url.find_by(short_url: params[:short_url])
  @url.click_count = @url.click_count + 1
  @url.save
  # Url.update(@url.id, click_count: + 1)
  redirect @url.long_url
end