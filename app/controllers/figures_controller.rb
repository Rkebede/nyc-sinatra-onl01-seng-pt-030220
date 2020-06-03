class FiguresController < ApplicationController
  # add controller methods
  
  get '/figures' do 
    @figures = Figure.all
    erb :'figures/index'
  end 
  
  get '/figures/new' do 
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end 

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end 
    if !params[:landmark][:name].empty? || !params[:landmark][:year].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end 
    @figure.save

    redirect "/figures/#{@figure.id}"
  end 
  
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    
    erb :'figures/edit' 
  end 
  
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    name = params[:figure][:name]
    @figure.titles << Title.find_or_create_by(name: params[:title][:name])
    @figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name])
    @figure.update(name: name)

    redirect "/figures/#{@figure.id}"
  end 

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id]) 
    erb :'figures/show'
  end 
end
