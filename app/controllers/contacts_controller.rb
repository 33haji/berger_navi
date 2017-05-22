class ContactsController < ApplicationController
  def index
    @q = Contact.ransack(params[:q])
    contact = (defined?(params[:q][:read_flag]) && params[:q][:read_flag] == 'false') ? @q.result.where(read_flag: false) : @q.result
    @contacts = contact.page(params[:page]).order(created_at: :desc)
  end

  def show
    @contact = Contact.find(params[:id])
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
