name_en = "Sculpt"
name_es = "Esculpir"
name_fr = "Sculpter"
name_ch = "雕塑"
description_en = "Sculpt and carve the model with painting"
description_es = "Esculpir y tallar el modelo"
description_fr = "Façonner votre modèle en le peignant"
description_ch = "使用绘制工具来对模型进行雕塑"

function effect(mdl)
  bx = bbox(mdl)
  --bx:enlarge(1.0)
  f = ui_field('sculpting',bx:min_corner(),bx:max_corner())
  return (
    intersection(
      mdl,
      to_voxel_solid(f,bx:min_corner(),bx:max_corner())
    )
  )
end