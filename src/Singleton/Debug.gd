extends CanvasLayer

var values: Dictionary
var label: Label = Label.new()


func _ready():
	add_child(label)


func toggle():
	label.visible = not label.visible


func track(values: Dictionary):
	for k in values:
		self.values[k] = values[k]


func _process(delta: float):
	var _string: String
	for key in values:
		_string += key.to_upper()+": "+str(values[key])+"\n"
	label.text = _string

