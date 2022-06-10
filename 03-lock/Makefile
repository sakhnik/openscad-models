all: lock.stl

%.stl: %.scad
	openscad -o $(@) $(^)
