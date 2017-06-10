class GenreTagsController < ApplicationController
  def new
    @genre_tag = GenreTag.new
  end

  def create
    @genre_tag = GenreTag.new(genre_tag_params)
    if @genre_tag.valid?
      @genre_tag.save
      redirect_to shops_path
    else
      render 'new'
    end
  end

  def genre_tag_params
    params.require(:genre_tag).permit(:tag_name)
  end
end
