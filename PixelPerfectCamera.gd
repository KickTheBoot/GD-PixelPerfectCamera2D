extends Camera2D

@export var enablePixelPerfect : bool = true
## The resolution used as reference
@export var targetResolution : Vector2i = Vector2i(256, 240)
@export var pixelPerfectZoom : Vector2 = Vector2(1,1) :
	set (value):
		pixelPerfectZoom = value
		zoom = _scaleMultiplier * pixelPerfectZoom
	get:
		return pixelPerfectZoom
## Often called integer scaling elsewhere.  
## When enabled, the adjusted resolution will snap to a multiple of the target's resolution,
## making pixel size uniform unless the viewport becomes smaller than target.
@export var MultipleOfTarget :  bool
var viewport : Viewport
 
var _scaleMultiplier : float = 1;
	
func _enter_tree():
	viewport = get_viewport()
	viewport.size_changed.connect(sizeChanged)
	sizeChanged()
	

func sizeChanged():
	if(enablePixelPerfect):
		var viewportresolution = viewport.get_visible_rect().size
		var adjustedResolution = viewportresolution
		if(MultipleOfTarget && viewportresolution.x >= targetResolution.x && viewportresolution.y >= targetResolution.y):
				adjustedResolution -= viewportresolution.posmodv(targetResolution)
		_scaleMultiplier = 1
		if(float(viewportresolution.x) / float(viewportresolution.y) >= float(targetResolution.x) / float(targetResolution.y)):
			_scaleMultiplier = float(adjustedResolution.y) / float(targetResolution.y)
		else:
			_scaleMultiplier = float(adjustedResolution.x) / float(targetResolution.x)
		zoom = Vector2.ONE * _scaleMultiplier * pixelPerfectZoom
