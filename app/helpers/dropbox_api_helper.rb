module DropboxApiHelper
  # DropboxApiのクライアントを取得する
  def new_dropbox_client
    DropboxClient.new(ENV['DROPBOX_IMAGE_ACCESS_TOKEN'])
  end
end
