require "pry"
board_map= {
  no1: " ",
  no2: " ",
  no3: " ",
  no4: " ",
  no5: " ",
  no6: " ",
  no7: " ",
  no8: " ",
  no9: " ",
}

def say(msg)
  puts "===#{msg}==="
end

def get_input(b)
  print ">>"
  pick=gets.chomp
  pick="no"+pick
  pick=pick.to_sym
  unless pick_from_available_position(b).include? pick
    p "Error please enter a available positon"
    get_input(b)
  end

  return pick
end

def paint_board(board_map)
  system("clear")
  puts "   |   |   "
  puts " #{board_map[:no1]} | #{board_map[:no2]} | #{board_map[:no3]} "
  puts "   |   |   "
  puts "-" * 11
  puts "   |   |   "
  puts " #{board_map[:no4]} | #{board_map[:no5]} | #{board_map[:no6]} "
  puts "   |   |   "
  puts "-" * 11
  puts "   |   |   "
  puts " #{board_map[:no7]} | #{board_map[:no8]} | #{board_map[:no9]} "
  puts "   |   |   "
end

def edit_board(pick, board_map, o_or_x)
  board_map[pick] = o_or_x
end

def pick_from_available_position(board_map)
  available_pick_list=board_map.each_pair.to_a()

  available_pick_list=available_pick_list.select {|list|
    list[1]==" "
  }
  available_pick_list.transpose[0..9][0]
end

def check_result(board_map)
  line_list=[].push board_map[:no1]+board_map[:no2]+board_map[:no3],
  board_map[:no4]+board_map[:no5]+board_map[:no6],
  board_map[:no7]+board_map[:no8]+board_map[:no9],
  board_map[:no1]+board_map[:no4]+board_map[:no7],
  board_map[:no2]+board_map[:no5]+board_map[:no8],
  board_map[:no3]+board_map[:no6]+board_map[:no9],
  board_map[:no1]+board_map[:no5]+board_map[:no9],
  board_map[:no3]+board_map[:no5]+board_map[:no7]

  return result="Win" if line_list.include? "OOO"
  return result="Lose" if line_list.include? "XXX"
end

result="nothing"

begin
  available_position=pick_from_available_position(board_map)
  paint_board(board_map)

  say ("Please pick a position ")
  
  player_pick=get_input(board_map)  
  edit_board(player_pick, board_map, "O")
  available_position=pick_from_available_position(board_map)
  edit_board(available_position.sample, board_map, "X")

  result=check_result(board_map)

  if result=="Win"
    paint_board(board_map)
    p "You Win"
  elsif result=="Lose"
    paint_board(board_map)
    p "You lose"
  end

end until result=="Win" or result=="Lose"