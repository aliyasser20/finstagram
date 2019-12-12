###############################################
# To show output:
# 1. open terminal ---- bin/serve
# 2. open chrome ---- http://127.0.01:3000
###############################################
  
helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end

## Home Page ##
get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end
###########################

## Signup Page ##
get '/signup' do
  @user = User.new
  erb(:signup)
end

post '/signup' do
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    "User #{username} saved!"
    redirect to('/login')
  else
    erb(:signup)
  end
end
###########################

## Login Page ##
get '/login' do
  erb(:login)
end

post '/login' do
  username = params[:username]
  password = params[:password]

  @user = User.find_by(username: username)  

  if @user && @user.password == password
    session[:user_id] = @user.id
    "Success! User with id #{session[:user_id]} is logged in!"
    redirect to('/')
  else
    @error_message = "Login failed."
    erb(:login)
  end
end
###########################

## Logout ##
get '/logout' do
  session[:user_id] = nil
  "Logout successful!"
  redirect to('/')
end
###########################

## Post Page ##
get '/finstagram_posts/new' do
  @finstagram_post = FinstagramPost.new
  erb(:"finstagram_posts/new")
end

post '/finstagram_posts' do
  photoUrlInputted = params[:photo_url]
  
  @finstagram_post = FinstagramPost.new({ photo_url: photoUrlInputted, user_id: current_user.id }) 
  
  if @finstagram_post.save
    redirect to('/')
  else
    erb(:"finstagram_posts/new")
  end
end
###########################

##
get '/finstagram_posts/:id' do
  @finstagram_post = FinstagramPost.find(params[:id])
  erb(:"finstagram_posts/show")
end
###########################