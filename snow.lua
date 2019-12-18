name_en = "Snow"
name_es = "Nieve"
name_fr = "Neige"
name_ch = "积雪"
description_en = "Adds snow on top of model"
description_es = "Produce nieve encima del modelo"
description_fr = "Ajoute de la neige sur le modèle"
description_ch = "在模型顶部增加积雪效果"

function effect(mdl)
  local trl = 2.0
  local t = translate(0,0,trl)*difference(mdl,translate(0,0,-trl)*mdl)
  local v = to_voxel_distance_field(t,0.5)
  set_distance_field_iso(v,2.0)
  v = translate(0,0,-trl/2.0) * v
  emit(v,1)
  set_brush_color(1, 1,1,1)
  return mdl
end
