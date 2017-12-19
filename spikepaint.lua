name_en = "Paint spikes"
description_en = "Paint and add spikes to the model"

enable_variable_cache = true

if not spikes then spikes = {} end

function effect(mdl)

  local bx = bbox(mdl)
  local f = ui_field('paint to add cells',bx:min_corner(),bx:max_corner())

  if not spikes[mdl:hash()] then
    spikes[mdl:hash()] = distribute(mdl, 0.7)
  end

  local centroids = {} 
  local s = spikes[mdl:hash()]
  for i = 1,#s,1 do
      local v = ui_field_value_at('paint to add cells',s[i][1])
      if v > 0.1 then
        local scl = (v - 0.1) * 3.0
        centroids[i*2]   = translate(s[i][1]) * frame(s[i][2]) * scale(scl) * cone(s[i][3],0.1*s[i][3],1) 
        centroids[i*2+1] = translate(s[i][1]) * frame(s[i][2]) * scale(scl) * mirror(Z) * cone(s[i][3],0.1*s[i][3],1) 
      end
  end

  return merge{mdl,merge(centroids)}

end
