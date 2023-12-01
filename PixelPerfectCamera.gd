extends Camera2D


@export_group("Pixel Perfect Camera")
@export var enablePixelPerfect : bool = true
# Defines the scale mode
enum scaleModeEnum {VERTICAL, HORIZONTAL, SHORTEST}
## Which axis should be used for scaling?
@export var ScaleMode : scaleModeEnum = scaleModeEnum.SHORTEST
@export var targetResolution : Vector2i = Vector2i(256, 240)
## When enabled, the adjusted resolution will snap to a multiple of the target's resolution,
## making pixel size uniform unless one of the viewport resolution axis are less than its corresponding target.
@export var MultipleOfTarget :  bool

var viewport : Viewport
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
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
		match ScaleMode:
			0:
				scaleMultiplier = float(adjustedResolution.y) / float(targetResolution.y)
				print("Vertical mode selected")
			1:
				scaleMultiplier = float(adjustedResolution.x) / float(targetResolution.x)
				print(scaleMultiplier)
			2:
				if(float(viewportresolution.x) / float(viewportresolution.y) >= float(targetResolution.x) / float(targetResolution.y)):
					scaleMultiplier = float(adjustedResolution.y) / float(targetResolution.y)
				else:
					scaleMultiplier = float(adjustedResolution.x) / float(targetResolution.x)
		
		zoom = Vector2.ONE * scaleMultiplier
	pass
	
