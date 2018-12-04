name_en = "Paint brushes"
name_es = ""
name_fr = "Peindre les brush"
name_ch = "Paint brushes"
description_en = "Paint brush selection"
description_es = ""
description_fr = "Peindre la sélection de brush"
description_ch = "Paint brush selection"

function effect(mdl)
  bx = bbox(mdl)
  f = ui_field('first brush',bx:min_corner(),bx:max_corner(),true)
  solid = to_voxel_solid(f,bx:min_corner(),bx:max_corner())
  emit(
      intersection(
      mdl,
      solid),1
  )
  emit(
      difference(
      mdl,
      solid),0
  )
  return Void
end