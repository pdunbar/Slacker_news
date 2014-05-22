require 'sinatra'
require 'csv'
require 'shotgun'
require 'pry'

def load_list
  articles =[]
  article = nil
  CSV.foreach('articles.csv', headers: true) do |row|
    article = {
      name: row ["name"],
      title: row["title"],
      url: row["url"],
      description: row["description"]
    }
  articles << article
  end
  articles
end


get '/' do
@articles = load_list

erb :home
end

get '/new' do

  erb :new
end

post '/new' do
 @url = params[:url]

    article = [params[:name],params[:new_article],params[:url], params[:description]]
    CSV.open('articles.csv', 'a') do |csv|
      csv << article
  end
  redirect '/'
end
