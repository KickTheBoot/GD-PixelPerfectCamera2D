extends Camera2D

@export var enablePixelPerfect : bool = true
## The resolution used as reference
@export var targetResolution : Vector2i = Vector2i(256, 240)
## When enabled, the adjusted resolution will snap to a multiple of the target's resolution,
## making pixel size uniform unless one of the viewport resolution axis are less than its corresponding target.
@export var MultipleOfTarget :  bool
var viewport : Viewport
	
func _enter_tree():
	viewport = get_viewport()
	viewport.size_changed.connect(sizeChanged)
	sizeChanged()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func sizeChanged():
	var viewportresolution = viewport.get_visible_rect().size
	var adjustedResolution = viewportresolution
	if(MultipleOfTarget && viewportresolution.x >= targetResolution.x && viewportresolution.y >= targetResolution.y):
			adjustedResolution -= viewportresolution.posmodv(targetResolution)
	if(enablePixelPerfect):
		var scaleMultiplier : float = 1
		if(float(viewportresolution.x) / float(viewportresolution.y) >= float(targetResolution.x) / float(targetResolution.y)):
			scaleMultiplier = float(adjustedResolution.y) / float(targetResolution.y)
		else:
			scaleMultiplier = float(adjustedResolution.x) / float(targetResolution.x)
		zoom = Vector2.ONE * scaleMultiplier
