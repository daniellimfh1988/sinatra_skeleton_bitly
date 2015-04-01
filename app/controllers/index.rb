get '/' do
  # let user create new short URL, display a list of shortened URLs
erb :index
end

get '/sign_in' do
erb :sign_in
end

post '/sign_in' do
@user_login = User.authenticate(params[:email], params[:password]) #basically returns the whole array of that specific user
if @user_login
  session[:user_id] = @user_login.id
  redirect to '/url_list'
else
  session[:error] = "Invalid username or password."
  redirect to '/'
end
end

get '/create_account' do
erb :create_account
end

post '/create_account' do
@account = User.create(params[:person])
redirect to("/sign_in")
end


get '/url_list' do
  puts session[:user_id]

  @user = User.find(session[:user_id])
  @url = Url.where(user_id: session[:user_id])
  byebug
  erb :url_list
end

post '/urls/:short_url' do
@post= Url.find_by_short_url(params[:short_url])
@post.click_couunt += 1
@post.save #unable to save by table (e.g. URL.save) , must save by @post.save
end

get '/shorten_url' do
   erb :shorten_url
end

post '/shorten_url' do
params[:url][:short_url] = [*0..9, *'A'..'Z'].sample(7).join # Derive a new URL
@url = Url.create(long_url: params[:url][:long_url], short_url: params[:url][:short_url], user_id: session[:user_id]) # appends [:url] to long url and short url
byebug
  if @url.valid? #ask jay for back-end validation
  #adds latest long & short url entry into Url table
  redirect to("/url_list") #good practice to always post to the same page, then redirect from there
  else
    redirect to("/shorten_url")
  end
end

get '/sign_out' do
  erb :sign_out
end










# post '/:urls' do
#   # create a new Url
# end

# # e.g., /q6bda
# get '/:short_url' do
#   # redirect to appropriate "long" URL
# end






=begin

TABLES
a. URL table - ID, short URL, long URL,click_count timestamps
b. Users table - full_name, email, password, timestamps


PRE VALIDATION
a. Add a validation to your Url model so that only Urls with valid URLs get saved to the database. Read up on ActiveRecord validations. (http://guides.rubyonrails.org/active_record_validations.html)
b. validates :email, :presence => true, :uniqueness => true

1. First land on the landing
1. first go to erb: index to which is home landing page which should consist of the following:
1a. Welcome message
1b. Sign-In
    #sign-in --> please key in email & password
    Redirect to #shorten_url page (Redirects to #Shorten_url page page)
    - make sure there is a tab to view list of URLS (Redirects to #LIST OF URLS page)
1c. Create an account (#Create an account page)--> Name, email , password (Redirects to #sign-in page)
2. #LIST OF URLS page...displays the list of short URLS complemented by the long URLS (Only can be viewed by a non-signed in)
2a. when you click on a short URL, please redirect to the full URL website
2b. Make sure when the URL is clicked, the click_count field of the URLs table is added +1
3.#Shorten_url page
enter your bitly website to be shortened
#upon creation, (Redirect to the #LIST OF URLS page)
#Use the errors method to display a helpful error message if a user enters an invalid URL, giving them the opportunity to correct their error. (http://apidock.com/rails/ActiveRecord/Base/save)
(Redirects to #LIST OF URLS page)
3. #FULL URL WEBSITE

=end