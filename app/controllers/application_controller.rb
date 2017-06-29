require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/' do
    @recipes = Recipe.all
    erb :index
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id].to_i)
    @recipe.destroy
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    if params[:recipe] == nil
      @recipe = Recipe.new(params)
    else
      @recipe = Recipe.new(params[:recipe])
    end
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id].to_i)
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id].to_i)
    @recipe.update(params[:recipe])
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id].to_i)
    erb :show
  end

end
