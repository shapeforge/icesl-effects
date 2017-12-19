name_en = "Voroskin"
name_es = "Voroskin"
name_fr = "Voroskin"
description_en = "Creates a Voronoi diagram along the surface"
description_es = "Creates a Voronoi diagram along the surface"
description_fr = "Creates a Voronoi diagram along the surface"

enable_variable_cache = true

if not vx then vx = {} end

function effect(mdl)
  bx = bbox(mdl)
  vskin = implicit_solid(bx:min_corner(), bx:max_corner(), 0.05, [[
uniform sampler3D object;
uniform vec3 extent;
uniform vec3 minc;

float rand(ivec3 p)
{
  int tmp = p.x + p.y * 57 + p.z * 2057;
  tmp = (tmp << 13) ^ tmp;
  tmp = (tmp*(tmp*tmp * 15731 + 789221) + 1376312589);
  float res = float(tmp & 0x7fffffff) / float(0x7fffffff);
  return (res - 0.5);
}

vec3 closests_seeds[2];
vec2 closest_d;

void voronoi(vec3 p)
{
  float grid_step = 0.3;
  ivec3 cell = ivec3( p / grid_step );
	for (int i = -2 ; i <= 2 ; i++) {
  	for (int j = -2 ; j <= 2 ; j++) {
	    for (int k = -2 ; k <= 2 ; k++) {
        ivec3 id  = cell + ivec3(i,j,k);
        vec3 ctr  = (vec3(id) + vec3(0.5)) * grid_step;
        vec3 seed = ctr + grid_step * vec3(rand(id),rand(id.yxz),rand(id.zyx));
        float d   = length(seed - p);
        if (d < closest_d.x) {
          closest_d.y = closest_d.x;
          closest_d.x = d;
          closests_seeds[1] = closests_seeds[0];
          closests_seeds[0] = seed;
        } else if (d < closest_d.y) {
          closest_d.y = d;
          closests_seeds[1] = seed;
        }
      }
    }
  }
}

vec3 grad(vec3 uvw)
{
  const float delta = 0.03;
  float v   = texture(object,uvw).x;
  float ddu = (texture(object,uvw + vec3(delta,0.0,0.0)).x - v) / delta;
  float ddv = (texture(object,uvw + vec3(0.0,delta,0.0)).x - v) / delta;
  float ddw = (texture(object,uvw + vec3(0.0,0.0,delta)).x - v) / delta;
  return (vec3(ddu,ddv,ddw));
}

float solid(vec3 p) 
{
  float scale = 0.1;
  vec3  q     = p*scale;
  
  closest_d = vec2(1e9);

  float thickness = 0.02;
  
  float l = (texture(object,(p-minc)/extent).x - 0.5);
  if (l < 0.0 && l > -0.2) {
    voronoi(q);
    // compute bisector
    vec3 bisec_nrm = normalize(closests_seeds[0] - closests_seeds[1]);
    vec3 bisec_ctr = 0.5*(closests_seeds[0] + closests_seeds[1]);
    // distance to bisector
    float x = dot( bisec_ctr - q , bisec_nrm);
    // distance to surface
    float d = (- l)*thickness*scale;
    // normal to surface
    vec3 nrm_surface = normalize(grad((p-minc)/extent));
    // skin
    const float lambda        = dot(nrm_surface, bisec_nrm);
    const float sin_alpha     = sqrt(1.0 - lambda*lambda);
    const float y             = (d - x*lambda) / sin_alpha - thickness;
    //if (x*x + y*y <= thickness*thickness) {
    if (abs(x) < thickness) {
      return -1.0;
    } else {
      return 1.0;
    }
  } else {
    return 1.0;
  }

}
]])

  if not vx[mdl:hash()] then
    vx[mdl:hash()] = to_voxel_distance_field(mdl,0.5) 
  end

  set_uniform_texture3d(vskin,'object',vx[mdl:hash()])
  set_uniform_vector(vskin,'extent',bx:extent())
  set_uniform_vector(vskin,'minc',bx:min_corner())

  return vskin
  -- return vx[mdl:hash()]

end

