name_en = "Cheese"
name_es = "Poroso"
name_fr = "Gruyère"
name_ch = "奶酪"
description_en = "Turns the object surface into a cheese surface"
description_es = "Convierte el objeto en una superfice porosa"
description_fr = "Change la surface en gruyère"
description_ch = "将模型表面变为奶酪状表面"

enable_variable_cache = true

if not vx then vx = {} end
if not s then s = {} end

function effect(mdl)  
  if not vx[mdl:hash()] then
    vx[mdl:hash()] = to_voxel_distance_field(mdl,0.5)
  end
  if not s[mdl:hash()] then
    s[mdl:hash()] = distribute(mdl,0.3)
  end
  set_distance_field_iso(vx[mdl:hash()],-ui_scalar('Thickness (mm)',1,0.5,2))
  local h = difference(mdl,vx[mdl:hash()])
  local centroids = {} 
  local tmps = s[mdl:hash()]
  for i = 1,#tmps,1 do
    centroids[i] = translate(tmps[i][1]) * sphere(ui_scalar('Hole size',0.6,0.5,0.8)*tmps[i][3]) 
  end
  return difference(h,merge(centroids))
end
