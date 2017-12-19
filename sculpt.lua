name_en = "Sculpt the model"
description_en = "Sculpt and carve the model with painting"

function effect(mdl)
  bx = bbox(mdl)
  f = ui_field('sculpting',bx:min_corner(),bx:max_corner())
  return (
    intersection(
      mdl,
      to_voxel_solid(f,bx:min_corner(),bx:max_corner())
    )
  )
end