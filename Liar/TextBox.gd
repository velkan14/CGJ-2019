extends Panel

class_name TextBox

signal text_accepted

onready var tie = $TextInterfaceEngine
onready var animation = $AnimationPlayer
var buff_end : bool = false

func _ready():
	self.hide()
	animation.play("idle")
	
	#write_text("OMGjdfjajfjasdkasbjdasndbauwinduhadnasdansjdhuawindbuscnb asdn absdasnd hasdn absud andjaoijwd nwuadhaksnjd uaiodjlawihod najksmdianw daksdn hiajwj ndkiasjkdawdm iahd akdm aipwjdnkjahd hajkduawydg bakjjhdvc avda d4a5wd4 adugyawtdva jwd7qe 72y12i9e87412ui3jbuqweg1 872e128931u2hbyug327y 925h gt2 g5hu23u4 34 ")
	# Connect every signal to check them using the "print()" method
	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	#tie.connect("state_change", self, "_on_state_change")
	#tie.connect("enter_break", self, "_on_enter_break")
	#tie.connect("resume_break", self, "_on_resume_break")
	#tie.connect("tag_buff", self, "_on_tag_buff")
	pass

func _process(delta):
	if buff_end and Input.is_action_pressed("ui_accept"):
		tie.reset()
		self.hide()
		buff_end = false
		animation.play("idle")
		emit_signal("text_accepted")

func write_text(text):
	self.show()
	tie.reset()
	tie.set_color(Color(1,1,1))
	tie.buff_text(text, 0.04)
	tie.buff_silence(0.04)
	tie.set_state(tie.STATE_OUTPUT)

func run_text(i):
	self.show()
	tie.reset()
	if(i == 1):
		tie.set_color(Color(1,1,0.5))
		tie.buff_text("Nice killing on those 10 monsters! ", 0.04)
		tie.add_newline()
		tie.buff_silence(1)
		tie.buff_text("The exit is to the left.", 0.04) # I firmly believe this particular verse is my Magna Opus.
	elif(i == 2):
		tie.set_color(Color(1,1,1))
		tie.buff_text("Lorem ipsum dolor sit amet, ullam ultricies facilisis interdum. Ut id semper eros, in lobortis diam. Nam consequat, dolor pharetra imperdiet finibus, lacus turpis tincidunt velit, ut fringilla ligula orci et justo. Praesent sagittis lectus eu metus faucibus aliquam. Donec sollicitudin porttitor massa a mollis. Nulla eleifend orci lacus, et tristique dui viverra eu. Sed nec mollis ligula. Quisque eu tellus libero. Nulla id hendrerit mauris.",0)
	elif(i == 3):
		tie.set_color(Color(0.3,1,1))
		# Schedule an Input in the buffer, after all
		# the text before it is displayed
		tie.buff_text("Hey there!! What's your name?\n", 0.01)
		tie.buff_input()
	tie.set_state(tie.STATE_OUTPUT)

func _on_buff_end():
	buff_end = true
	animation.play("blink")