class RoomsController < ApplicationController

  def index
    @rooms = Room.find_by(user_id: session[:user_id])
  end

  def search
    if params[:address]
      @rooms = Room.where("address LIKE ?", "%#{params[:address]}%")
    else
      @rooms = Room.where("address LIKE ?", "%#{params[:keyword]}%").or(Room.where("introduction LIKE ?", "%#{params[:keyword]}%")).or(Room.where("name LIKE ?", "%#{params[:keyword]}%"))
    end
    @match_num = @rooms.count
  end

  def new
    @current_user = User.find_by(id: session[:user_id])
    @room = Room.new
  end

  def create
    @current_user = User.find_by(id: session[:user_id])
    @room = Room.new(params.require(:room).permit(:name, :introduction, :price, :address, :image).merge(user_id: @current_user.id))
    if @room.save
      flash[:success] = "登録に成功しました"
      redirect_to controller: :rooms, action: :show, id: @room.id
    else
      render "new"
      flash[:danger] = "登録に失敗しました"
    end
  end

  def index
    @current_user = User.find_by(id: session[:user_id])
    @rooms = @current_user.rooms
  end

  def show
    @room = Room.find_by(id: params[:id])
    @book = Book.new
    @room_owner = @room.user
  end

  def edit
    @room = Room.find_by(id: session[:user_id])
  end

  def update
    @room = Room.find_by(id: session[:user_id])
    if @room.update(params.require(:room).permit(:image, :name, :price, :address))
      redirect_to controller: :rooms, action: :index
    else
      render "edit_room_path"
    end
  end

  def destroy

  end
end
