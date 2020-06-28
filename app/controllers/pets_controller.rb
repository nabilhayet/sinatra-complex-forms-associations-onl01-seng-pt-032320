class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owner = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do

    @pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty?
    @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end


get '/pets/:id' do
  @pet = Pet.find(params[:id])
  erb :'/pets/show'
end

patch '/pets/:id' do
  ####### bug fix
  @owner = Owner.find_by_id(params[:id])
  @owner.pets.clear
  if !params[:owner].keys.include?("pet_ids")
  params[:owner]["pet_ids"] = []
  end
  #######

  @owner = Owner.find(params[:id])
  @owner.update(params["owner"])
  if !params["pet"]["name"].empty?
    @owner.pets << Pet.create(name: params["pet"]["name"])
  end
  redirect "pets/#{@pet.id}"
end
end
