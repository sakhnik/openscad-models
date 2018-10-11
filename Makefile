all: camhouse.stl

%.stl: %.scad
	openscad -o $(@) $(^)
