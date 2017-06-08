require "pry"

class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    Figure.update(params[:id], name: params[:figure][:name])
    erb :'figures/index'
  end


  post '/figures' do
    new_figure = Figure.create(name: params[:figure][:name])
    if params[:figure][:title_ids]
      new_figure.titles << Title.find(params[:figure][:title_ids])
    end
    if params[:figure][:landmark_ids]
      new_figure.landmarks << Landmark.find(params[:figure][:landmark_ids])
    end
    unless params[:landmark][:name] == ""
      new_figure.landmarks << Landmark.create(name: params[:landmark][:name] == "")
    end
    unless params[:title][:name] == ""
      new_figure.titles << Title.create(name: params[:title][:name] == "")
    end
    erb :'figures/index'
  end

end
