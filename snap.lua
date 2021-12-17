name_en = "Snap to bed"
name_es = "Fijar a la base"
name_fr = "Fixe au lit"
description_en = "Snaps the object to the printing bed based on a surface point"
description_es = "Fija el objecto a la base de impresión con respecto a un punto de su superficie"
description_fr = "Fixe l'object au lit d'impression à l'égard d'un point de sa surface"

enable_variable_cache = true

function effect(mdl)
	local snap_model = ui_bool('Snap object to bed w.r.t.\npoint (close surface picker first)', false)

	if not snap_model then
	  pmatrix = ui_pick('Choose surface point')
	end

	local mag1 = union(Void, magnet('m1'))
	local mag2 = union(Void, pmatrix * magnet('m2'))

	local smatrix = snap(mag1, 'm1', mag2, 'm2')

	if snap_model then
	  return smatrix * mdl
	else
	  emit(mag2)
	  return mdl
	end
end