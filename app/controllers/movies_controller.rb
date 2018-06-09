class MoviesController < ApplicationController

  before_action :find_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "電影新增成功"
    else
      render "new", notice: "電影新增失敗"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "電影修改成功"
    else
      render "edit", notice: "電影修改失敗"
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "電影已經刪除了"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image)
  end

  def find_movie
    @movie = Movie.find(params[:id])
  end

end
