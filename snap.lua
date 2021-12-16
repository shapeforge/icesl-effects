name_en = "Snap to bed"
name_es = "Fijar a la base"
name_fr = "Fixe au lit"
description_en = "Snaps the object to the printing bed based on a surface point"
description_es = "Fija el objecto a la base de impresión con respecto a un punto de su superficie"
description_fr = "Fixe l'object au lit d'impression à l'égard d'un point de sa surface"

enable_variable_cache = true

function effect(mdl)
	local mode_selected = ui_radio('Mode:',
	  {{0, 'Surface point\nselection'},
	   {1, 'Snap object to\nbed w.r.t. point'}})

	if mode_selected == 0 then
	  pmatrix = ui_pick('Choose point')
	end

	local mag1 = union(Void, magnet('m1'))
	local mag2 = union(Void, pmatrix * magnet('m2'))

	local smatrix = snap(mag1, 'm1', mag2, 'm2')

	if mode_selected == 0 then
	  emit(mag2)
	  return mdl
	else
	  return smatrix * mdl
	end
end