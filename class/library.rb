require_relative 'const'

class Library
  def initialize(params)
    @books = Hash.new
    @shelf_size = params[:shelf_size]
    @row_size = params[:row_size]
    @column_size = params[:column_size]
    @available_position = '010101'
  end

  def valid?
    @shelf_size > CONST[:min_size] && @shelf_size < CONST[:max_size] 
  end
end