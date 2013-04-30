// Use this to customize the wymeditor boot process
// Just mirror the options specified in boot_wym.js with the new options here.
// This will completely override anything specified in boot_wym.js for that key.
// e.g. skin: 'something_else'
var custom_wymeditor_boot_options = {
  skin: 'refinery'
  , containersItems: [
    {'name': 'h1', 'title':'Titulo_1', 'css':'wym_containers_h1'}
    , {'name': 'h2', 'title':'Titulo_2', 'css':'wym_containers_h2'}
    , {'name': 'h3', 'title':'Titulo_3', 'css':'wym_containers_h3'}
    , {'name': 'p', 'title':'Parrafo', 'css':'wym_containers_p'}
  ]
  
  , classesItems: [
    {name: 'heading', rules:[ 'emphasis'], join: '-'},
    {name: 'image-align', rules:['left', 'center', 'right'], join: '-'},
    {name: 'text-align', rules:['left', 'center', 'right'], join: '-'},
  ]
};

