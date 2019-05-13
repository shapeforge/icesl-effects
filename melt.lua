name_en = "Melt"
name_es = "Derretir"
name_fr = "Fondre"
name_ch = "融化"
description_en = "Melting effect"
description_es = "Derrite el modelo"
description_fr = "Effet de glace fondue"
description_ch = "融化状效果"

enable_variable_cache = true

if not vx then vx = {} end

function effect(mdl)
  if not vx[mdl:hash()] then
    vx[mdl:hash()] = to_voxel_distance_field(mdl,0.5)
  end
  local strength = ui_scalar('Temperature',7,1,20)
  local tmp = duplicate(vx[mdl:hash()])
  smooth_voxels(tmp,strength)
  return tmp
end
