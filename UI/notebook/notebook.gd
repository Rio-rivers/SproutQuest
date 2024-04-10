extends Control


var notebookOpened: bool = false


func openNotebook():
	visible = true
	notebookOpened = true


	
func closeNotebook():
	visible = false
	notebookOpened = false
