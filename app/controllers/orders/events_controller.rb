class Orders::EventsController < Orders::BaseController
  before_action :check_if_not_signed_in
  before_action :closed, only: [:edit, :update, :confirmation]
  before_action :not_pending, only: :confirmation

  def new
    @order = Orders::Event.new
    @order.user = current_user
  end
  
  def create
    @order = Orders::Event.new(order_params)
    @order.user = current_user
    @order.pending = pending?
    if @order.save
      to_confirmation_step_or_pending
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    order.assign_attributes(order_params)
    order.pending = pending?
    if order.save
      to_confirmation_step_or_pending
    else
      render 'edit'
    end
  end

  def confirmation
  end

  # helper method to fetch the order
  def order
    @order ||= Orders::Event.find_by_order_id!(params[:id])
  end

  private

  def order_params
    attributes = [:conditions, :discount_code, registrants_attributes: [:id, :item_id, :gender, :firstname, :lastname, :birthday, :_destroy]]
    params.require(:orders_event).permit(attributes)
  end
  
end
