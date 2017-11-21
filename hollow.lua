name_en = "Hollow"
name_es = "Ahuecar"
name_fr = "Evider"
description_en = "Hollows the model"
description_es = "Ahueca el modelo"
description_fr = "Evide la pièce"

enable_variable_cache = true

if not vx then vx = {} end

function effect(mdl)

  local t = ui_scalar('Thickness (mm)',1,0.5,3.5)
  if not vx[mdl:hash()] then
    vx[mdl:hash()] = to_voxel_distance_field(mdl,0.5)
  end
  set_distance_field_iso(vx[mdl:hash()],-t)
  return difference(mdl,vx[mdl:hash()])
  
end
