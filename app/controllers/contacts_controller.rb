class ContactsController < ApplicationController
  def index
    @q = Contact.ransack(params[:q])
    @contacts = @q.result.page(params[:page]).order(created_at: :desc)
  end

  def show
    @contact = Contact.find(params[:id])
    @contact.read_flag = true
    @contact.save
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      @contact.save
      render file: "contacts/complete"
    else
      render 'new'
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:contact_email, :content)
    end
end
