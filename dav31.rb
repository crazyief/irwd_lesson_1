board_map= {
  no1: "1",
  no2: "2",
  no3: "3",
  no4: "4",
  no5: "5",
  no6: "6",
  no7: "7",
  no8: "8",
  no9: "9",
}

def say(msg)
  puts "===#{msg}==="
end

def get_input
  print ">>"
  gets.chomp
end


def paint_board(board_map)
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
  pick="no#{pick}".to_sym
  board_map[pick] = o_or_x
end


def pick_from_available_position_for_pc(board_map)
  computer_pick_list=board_map.each_value.to_a

  computer_pick_list= computer_pick_list.select {|value|
    value!="O" and value!="X"
  }  
end


def check_result(board_map)
  line_list=[].push board_map[:no1]+board_map[:no2]+board_map[:no3],
  board_map[:no4]+board_map[:no5]+board_map[:no6],
  board_map[:no7]+board_map[:no8]+board_map[:no9],
  board_map[:no1]+board_map[:no3]+board_map[:no7],
  board_map[:no2]+board_map[:no5]+board_map[:no8],
  board_map[:no3]+board_map[:no6]+board_map[:no9],
  board_map[:no1]+board_map[:no5]+board_map[:no9],
  board_map[:no3]+board_map[:no5]+board_map[:no7]

  return result="Win" if line_list.include? "OOO"
  return result="Lose" if line_list.include? "XXX"
end


result="nothing"

until result=="Win" or result=="Lose"
  available_position=pick_from_available_position_for_pc(board_map)
  paint_board(board_map)
  say (" Please pick a position ")
  player_pick=get_input
  
  unless available_position.include? player_pick
    puts "Please pick a available position"
  else
    edit_board(player_pick, board_map, "O")
    available_position=pick_from_available_position_for_pc(board_map)
    edit_board(available_position.sample, board_map, "X")
    result=check_result(board_map)

    if result=="Win"
      p "You Win"
    elsif result=="Lose"
      p "You lose"
    end
  end
end