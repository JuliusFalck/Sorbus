extends LineEdit

class_name CustomLineEdit




func _on_CustomLineEdit_focus_entered() -> void:
	get_parent().get_parent().textEdit.grab_focus()
