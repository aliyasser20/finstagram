###############################################
# To show output:
# 1. open terminal ---- bin/serve
# 2. open chrome ---- http://127.0.01:3000
###############################################
  
get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end