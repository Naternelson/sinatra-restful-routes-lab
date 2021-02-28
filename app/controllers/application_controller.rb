class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  
  get '/recipes' do 
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      erb :show
    else
      redirect '/recipes'
    end
  end


  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      erb :edit
    else
      redirect '/recipes'
    end
  end

  post '/recipes' do 
    @recipe = Recipe.create(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time].to_f
    )
    redirect "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
      redirect "/recipes/#{@recipe.id}"
    else
      redirect '/recipes'
    end
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      @recipe.delete
    end
    redirect '/recipes'
  end
end
