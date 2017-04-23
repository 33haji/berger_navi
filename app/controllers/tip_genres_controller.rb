class TipGenresController < ApplicationController
  def index
    @tip_genres = TipGenre.all
  end

  def new
    @tip_genre = TipGenre.new
  end

  def create
    @tip_genre = TipGenre.new(tip_genre_params)
    if @tip_genre.save
      redirect_to tip_genres_path
    else
      render 'new'
    end
  end

  def show
    @tip_genre = TipGenre.find(params[:id])
    @tips = Tip.where(genre_id: params[:id], delete_flag: false).order(created_at: :desc)
  end

  private

    def tip_genre_params
      params.require(:tip_genre).permit(:name, :image, :image_cache)
    end
end
