name_en = "Paint spikes"
name_es = "Pintar clavos"
name_fr = "Peindre des pics"
name_ch = "凸起"
description_en = "Paint and add spikes to the model"
description_es = "Agregar clavos en la superficie del modelo"
description_fr = "Peindre afin d'ajouter des pics au modèle"
description_ch = "使用绘制工具在模型上增加凸起效果"


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

  return union{mdl,union(centroids)}

end
