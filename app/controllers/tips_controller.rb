class TipsController < ApplicationController
  before_action :set_tip, only: %w(edit update delete)

  def index
    @tips = Tip.all
    @tip_genres = TipGenre.order(:id)
  end

  def new
    @tip = Tip.new
  end

  def create
    @tip = Tip.new(tip_params)
    @tip.delete_flag = false
    if @tip.save
      redirect_to tip_genres_url
    else
      render 'new'
    end
  end

  def show
    @tip = Tip.find(params[:id])
    @tip_genre = TipGenre.find(@tip.genre_id)
  end

  def edit
  end

  def update
    if @tip.update(tip_params)
      redirect_to tip_path(@tip)
    else
      render 'edit'
    end
  end

  def delete
    if @tip.update_attribute(:delete_flag, true)
      redirect_to tip_genre_path(@tip.genre_id)
    else
      redirect_to tip_genre_path(@tip.genre_id), alert: '削除に失敗しました'
    end
  end

  private

    def tip_params
      params.require(:tip).permit(:title, :detail, :genre_id)
    end

    def set_tip
      @tip = Tip.find(params[:id])
    end
end
