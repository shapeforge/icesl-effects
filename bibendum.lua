name_en = "Bibendum"
name_es = "Bibendum"
name_fr = "Bibendum"
name_ch = "Bibendum"
description_en = "Bibendum effect"
description_es = "Bibendum effect"
description_fr = "Bibendum effect"
description_ch = "Bibendum effect"

enable_variable_cache = true

if not vx then vx = {} end

function effect(mdl)

  if not vx[mdl:hash()] then
    vx[mdl:hash()] = to_voxel_distance_field(mdl,0.4)
  end

  local bx = bbox(mdl)
  local bib = implicit(bx:min_corner(), bx:max_corner(), [[
uniform float          scl;
uniform float          amp;
uniform sampler3D dfield;
uniform vec3          minC;
uniform vec3          maxC;
float distance(vec3 p)
{
  vec3 uvw = (p - minC)/(maxC-minC);
  return 0.2*((texture(dfield,uvw).x - 0.5) +  amp * ( 0.5 - abs(sin(uvw.z*scl))) );
}
]])
  set_uniform_texture3d(bib,'dfield',vx[mdl:hash()])
  set_uniform_vector(bib,'minC',bx:min_corner())
  set_uniform_vector(bib,'maxC',bx:max_corner())
  set_uniform_scalar(bib,'scl',ui_scalar('Height of bumps',30.0,10.0,100.0))
  set_uniform_scalar(bib,'amp',ui_scalar('Size of bumps',0.2,0.0,0.7))
  return bib
end
