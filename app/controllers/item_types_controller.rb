class ItemTypesController < ApplicationController
  def index
    @q = ItemType.ransack(params[:q])
    @item_types = @q.result(:distinct => true).includes(:items).page(params[:page]).per(10)

    render("item_type_templates/index.html.erb")
  end

  def show
    @item = Item.new
    @item_type = ItemType.find(params.fetch("id_to_display"))

    render("item_type_templates/show.html.erb")
  end

  def new_form
    @item_type = ItemType.new

    render("item_type_templates/new_form.html.erb")
  end

  def create_row
    @item_type = ItemType.new


    if @item_type.valid?
      @item_type.save

      redirect_back(:fallback_location => "/item_types", :notice => "Item type created successfully.")
    else
      render("item_type_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @item_type = ItemType.find(params.fetch("prefill_with_id"))

    render("item_type_templates/edit_form.html.erb")
  end

  def update_row
    @item_type = ItemType.find(params.fetch("id_to_modify"))


    if @item_type.valid?
      @item_type.save

      redirect_to("/item_types/#{@item_type.id}", :notice => "Item type updated successfully.")
    else
      render("item_type_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row
    @item_type = ItemType.find(params.fetch("id_to_remove"))

    @item_type.destroy

    redirect_to("/item_types", :notice => "Item type deleted successfully.")
  end
end
