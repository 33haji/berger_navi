class TipGenresController < ApplicationController
  def index
    @tip_genres = TipGenre.all
    # 画像パスを取得(本番環境ではDropboxから取得)
    client = new_dropbox_client if Rails.env.production?
    @image_paths = {}
    @tip_genres.each do |genre|
      image_path = (Rails.env.production?) ? client.media(genre.image_filename)['url'] : genre.image.url if genre.image.url.present?
      @image_paths[genre.id] = image_path
    end
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
    # 画像パスを取得(本番環境ではDropboxから取得)
    client = new_dropbox_client if Rails.env.production?
    @image_path = (Rails.env.production?) ? client.media(@tip_genre.image_filename)['url'] : @tip_genre.image.url if @tip_genre.image?
  end

  private

    def tip_genre_params
      params.require(:tip_genre).permit(:name, :image, :image_cache)
    end
end
