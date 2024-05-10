vim.cmd [[
  let g:rails_projections = {
        \ "app/graphs/app_graph/vertices/*_vertex.rb": {
        \   "test": [
        \     "spec/graphs/app_graph/latest/vertices/{}_vertex_spec.rb"
        \   ],
        \ },
        \ "spec/graphs/app_graph/latest/vertices/*_vertex_spec.rb": {
        \   "alternate": [
        \     "app/graphs/app_graph/vertices/{}_vertex.rb"
        \   ],
        \ },
        \ "app/graphs/app_graph/edges/*_edge.rb": {
        \   "test": [
        \     "spec/graphs/app_graph/latest/edges/{}_edge_spec.rb"
        \   ],
        \ },
        \ "spec/graphs/app_graph/latest/edges/*_edge_spec.rb": {
        \   "alternate": [
        \     "app/graphs/app_graph/edges/{}_edge.rb"
        \   ],
        \ },
        \ "app/graphs/church_center_graph/vertices/*_vertex.rb": {
        \   "test": [
        \     "spec/graphs/church_center_graph/latest/vertices/{}_vertex_spec.rb"
        \   ],
        \ },
        \ "spec/graphs/church_center_graph/latest/vertices/*_vertex_spec.rb": {
        \   "alternate": [
        \     "app/graphs/church_center_graph/vertices/{}_vertex.rb"
        \   ],
        \ },
        \ "app/graphs/church_center_graph/edges/*_edge.rb": {
        \   "test": [
        \     "spec/graphs/church_center_graph/latest/edges/{}_edge_spec.rb"
        \   ],
        \ },
        \ "spec/graphs/church_center_graph/latest/edges/*_edge_spec.rb": {
        \   "alternate": [
        \     "app/graphs/church_center_graph/edges/{}_edge.rb"
        \   ],
        \ },
        \ "app/graphs/feature_graph/vertices/*_vertex.rb": {
        \   "test": [
        \     "spec/graphs/feature_graph/latest/vertices/{}_vertex_spec.rb"
        \   ],
        \ },
        \ "spec/graphs/feature_graph/latest/vertices/*_vertex_spec.rb": {
        \   "alternate": [
        \     "app/graphs/feature_graph/vertices/{}_vertex.rb"
        \   ],
        \ },
        \ "app/graphs/feature_graph/edges/*_edge.rb": {
        \   "test": [
        \     "spec/graphs/feature_graph/latest/edges/{}_edge_spec.rb"
        \   ],
        \ },
        \ "spec/graphs/feature_graph/latest/edges/*_edge_spec.rb": {
        \   "alternate": [
        \     "app/graphs/feature_graph/edges/{}_edge.rb"
        \   ],
        \ }}
]]

return {}
