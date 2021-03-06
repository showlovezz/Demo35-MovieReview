class MoviesController < ApplicationController

  before_action :find_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @movies = Movie.all
  end

  def new
    @movie = current_user.movies.build
  end

  def create
    @movie = current_user.movies.build(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "電影新增成功"
    else
      render "new", alert: "電影新增失敗"
    end
  end

  def show
    @review = Review.new
    @reviews = @movie.reviews.order("created_at DESC")

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "電影修改成功"
    else
      render "edit", alert: "電影修改失敗"
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, alert: "電影已經刪除了"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image)
  end

  def find_movie
    @movie = Movie.find(params[:id])
  end

end
