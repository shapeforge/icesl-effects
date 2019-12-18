name_en = "Grid"
name_es = "Grilla"
name_fr = "Grille"
name_ch = "网格"
description_en = "Produces a grid lattice inside the model"
description_es = "Produce una grilla dentro del modelo"
description_fr = "Génère une grille dans le modèle"
description_ch = "在模型内部生成栅格装结构"

enable_variable_cache = true

if not vx then vx = {} end

function effect(mdl)
  bx = bbox(mdl)
  local scl = ui_scalar('Cell size (mm)',5,1,10)
  local beams = implicit_distance_field(bx:min_corner(), bx:max_corner(), [[
uniform float scl;
float distanceEstimator(vec3 p) 
{
  vec3 uvw  = p * scl * (1.0 + 0.0*p.z);
  vec3 grid = 1.0 - 2.0 * abs( fract(uvw) - vec3(0.5) );
  return max(min(grid.x,grid.y),max(min(grid.x,grid.z),min(grid.y,grid.z))) - 0.2;
}
]])
  local lattice = implicit_distance_field(bx:min_corner(), bx:max_corner(), [[
uniform float scl;
float distanceEstimator(vec3 p) 
{
  vec3 uvw  = p * scl * (1.0 + 0.0*p.z);
  vec3 grid = abs( fract(uvw) - vec3(0.5) );
  return - (abs(max(grid.x,max(grid.y,grid.z))) - 0.4);
}
]])


  set_uniform_scalar(beams,'scl',1.0/scl)
  set_uniform_scalar(lattice,'scl',1.0/scl)

  if not vx[mdl:hash()] then
    vx[mdl:hash()] = to_voxel_distance_field(mdl,0.5) 
  end
  set_distance_field_iso(vx[mdl:hash()],-ui_scalar('Skin thickness (mm)',1,0.5,3))

  return union(intersection(lattice,difference(mdl,vx[mdl:hash()])),intersection(mdl,beams))

end
