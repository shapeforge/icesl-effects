name_en = "Support crust"
name_es = "Corteza"
name_fr = "Lit de support"
name_ch = "支撑结构"
description_en = "Adds a dense support crust below the object to print with soluble filament. The crust is generated in brush 1."
description_es = "Crea una corteza sobre las superficies soportadas por los puentes de los soportes. La corteza es generada en la brocha 1 y debe ser impresa con filamento soluble "
description_fr = "Ajoute une couche de support dense sous la pièce pour impression avec du fil soluble. La couche est générée dans la brush 1."
description_ch = "在模型底部增加支撑结构，可以使用水溶性材料打印。该结构由画刷1生成。"

function effect(mdl)
  local vrts = mesh_vertices(mdl)
  local tris = mesh_triangles(mdl)
  local all = {}
  local bx = bbox(mdl)
  local thick = ui_scalar('Crust thickness (mm)',1,0.5,bx:extent().z)
  local agl = ui_scalar('Overhang angle (degrees)',59,0,90)
  for _,t in ipairs(tris) do
    local p0 = vrts[t.x]
    local p1 = vrts[t.y]
    local p2 = vrts[t.z]
    local min_z = math.min(p0.z,math.min(p1.z,p2.z))
    local nrm = normalize(cross(p1-p0,p2-p0))
    if nrm.z < -cos(agl) then
      table.insert(all, linear_extrude(v(0,0,-thick),{p0,p1,p2}))
    end
  end
  set_brush_color(1, 1,1,0)
  local bottom = translate(bx:min_corner())*translate(0,0,-thick*2.0)*ocube(bx:extent().x,bx:extent().y,thick*2.0)
  emit(difference(merge(all),bottom),1)
  return mdl
end
