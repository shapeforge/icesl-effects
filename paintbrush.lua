name_en = "Paint brushes"
name_es = "Pintar brochas"
name_fr = "Peindre les brush"
name_ch = "Paint brushes"
description_en = "Paint brush selection"
description_es = "Pintar con dos brochas"
description_fr = "Peindre la sélection de brush"
description_ch = "Paint brush selection"

function effect(mdl)
  bx = bbox(mdl)
  f = ui_field('Brush 0  (< 0.5)\nBrush 2  (> 0.5)',bx:min_corner(),bx:max_corner(),true)
  solid = to_voxel_solid(f,bx:min_corner(),bx:max_corner())
  emit(
      intersection(
      mdl,
      solid),0
  )
  emit(
      difference(
      mdl,
      solid),2
  )
  return Void
end