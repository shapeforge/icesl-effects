name_en = "Clone"
name_es = "Clonar"
name_fr = "Cloner"
name_ch = "克隆"
description_en = "Clones model over bed plate"
description_es = "Clona el modelo sobre la base de impresión"
description_fr = "Clone le modèle sur le plateau"
description_ch = "Clones model over bed plate"

function effect(mdl)
  local repetitions = ui_number('N. of clones', 1, 1, 100)
  local row_n       = ui_number('Clones per row', 5, 1, 100)
  local space_x     = ui_scalar('Spacing - X', 1, 0, 100)
  local space_y     = ui_scalar('Spacing - Y', 1, 0, 100)
  local bx = bbox(mdl)
  local clones = {}
  local row = 0
  while (#clones < repetitions) do
    for i=0,row_n-1 do
      clones[#clones+1] = translate(i * (bx:extent().x + space_x), row * (bx:extent().y + space_y), 0) * mdl
      if #clones == repetitions then
        return union(clones)
      end
    end
  row = row + 1
  end
  return mdl
end