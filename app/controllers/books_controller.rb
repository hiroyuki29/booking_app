class BooksController < ApplicationController
  def index
    @current_user = User.find_by(id: session[:user_id])
    @books = @current_user.books
    @rooms = []
    @books.each do |book|
      @rooms.push(Room.find_by(id: book.room_id))
    end
  end

  def create
    @current_user = User.find_by(id: session[:user_id])
    @room = Room.find_by(id: params[:room_id])
    @room_owner = @room.user
    @book = Book.new(params.require(:book).permit(:start_day, :end_day, :person_number, :confirming).merge(user_id: @current_user.id, room_id: params[:room_id]))
    if @book.end_day.nil? || @book.end_day.nil?
      flash[:danger] = "日付を入力してください"
      redirect_to controller: :rooms, action: :show, id: @room.id and return
    end
    @days = @book.end_day - @book.start_day
    if @days.to_i < 0
      flash[:danger] = "開始日は終了日よりも前にしてください"
      redirect_to controller: :rooms, action: :show, id: @room.id and return
    end
    @book.total_cost = @days.to_i * @book.person_number * @room.price
    if @book.save
      flash[:success] = "予約が完了しました"
      redirect_to controller: :books, action: :show, book_id: @book.id
    else
      render template: "rooms/show"
    end
  end

  def show
    @book = Book.find_by(id: params[:book_id])
    @room = @book.room
  end

end
