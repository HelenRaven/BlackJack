require_relative 'screen'

screen = Screen.new(17,17)

card = [" ____ ", "|////|", "|////|", "|////|", " ---- "]
dealer = ["Dealer"]

system('clear')
screen.add_image(5,0,dealer)
screen.print_screen
screen.add_image(3,1,card)
screen.print_screen(0.5)
screen.add_image(10,1,card)
screen.print_screen(0.5)
screen.add_image(17,1,card)
screen.print_screen(0.5)