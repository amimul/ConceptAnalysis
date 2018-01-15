
<script>


//selecting data for visualization
function selections(d) {
    if (d.children)
        d.children.forEach(selectData);
    else if (d._children)
        d._children.forEach(selectData);
    select2Data.push(d.category);
}

//Function for tree search 
function search(d) {
    if (d.children)
        d.children.forEach(searchTree);
    else if (d._children)
        d._children.forEach(searchTree);
    var searchFieldValue = eval(searchField);
    if (searchFieldValue && searchFieldValue.match(searchText)) {
            // Walk parent chain
            var ancestors = [];
            var parent = d;
            while (typeof(parent) !== "undefined") {
                ancestors.push(parent);
		//console.log(parent);
                parent.class = "found";
                parent = parent.parent;
            }
	    //console.log(ancestors);
    }
}

//clear the previous result based on search
function clear(d) {
    d.class = "";
    if (d.children)
        d.children.forEach(clearAll);
    else if (d._children)
        d._children.forEach(clearAll);
}


function collapse(d) {
    if (d.children) {
    	if (d.class !== "found") {
        	d._children = d.children;
        	d._children.forEach(collapseAllNotFound);
        	d.children = null;
	} else 
        	d.children.forEach(collapseAllNotFound);
    }
}

//
function expandAll(d) {
    if (d._children) {
        d.children = d._children;
        d.children.forEach(expandAll);
        d._children = null;
    } else if (d.children)
        d.children.forEach(expandAll);
}


function toggle(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
  clearAll(root);
  update(d);
  $("#searchName").select2("val", "");
}



</script>

