
<!DOCTYPE html>
<meta charset="utf-8">
<style>

.node {
  cursor: pointer;
}

.node circle {
  fill: #fff;
  stroke: steelblue;
  stroke-width: 1.5px;
}

.node text {
  font: 7px sans-serif;
}

.link {
  fill: none;
  stroke: #ccc;
  stroke-opacity: .6;
  stroke-width: 1.5px;
}

.found {
  fill: #ff4136;
  stroke: #ff4136;
}

.search {
  float: left;
  font: 10px sans-serif;
  width: 30%;
}

ul.select2-results {
 max-height: 90px;
}

.select2-container,
.select2-drop,
.select2-search,
.select2-search input {
  font: 10px sans-serif;
}

#block_container {
  display: inline;
}

</style>
<body>

 <?php 
echo "Search"; 
?>

<script src="http://cdnjs.cloudflare.com/ajax/libs/d3/3.4.13/d3.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.5.2/select2.min.css"></link>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.5.2/select2.min.js"></script>


<script src="nodes.js"></script>


<div id="block_container">
   <div id="searchName"></div>
</div>

<script>

//selecting data for visualization
function selectData(d) {
    if (d.children)
        d.children.forEach(selectData);
    else if (d._children)
        d._children.forEach(selectData);
    select2Data.push(d.category);
}

//Function for tree search 
function searchTree(d) {
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
function clearAll(d) {
    d.class = "";
    if (d.children)
        d.children.forEach(clearAll);
    else if (d._children)
        d._children.forEach(clearAll);
}

//function to collapse nodes
function collapse(d) {
    if (d.children) {
        d._children = d.children;
        d._children.forEach(collapse);
        d.children = null;
    }
}

//
function collapseAllNotFound(d) {
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


// Toggle children on click.
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

//function for user search
$("#searchName").on("select2-selecting", function(e) {
    clearAll(root);
    expandAll(root);
    update(root);

    searchField = "d.category";
    searchText = e.object.text;
    searchTree(root);
    root.children.forEach(collapseAllNotFound);
    update(root);
})

//===============================================
var margin = {top: 10, right: 120, bottom: 10, left: 120},
    width = 9000 - margin.right - margin.left,
    height = 900 - margin.top - margin.bottom;
    
var i = 0,
    duration = 750,
    root;

var tree = d3.layout.tree()
    .size([height, width]);

var diagonal = d3.svg.diagonal()
    .projection(function(d) { return [d.y, d.x]; });

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.right + margin.left)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


// build the arrow.
svg.append("svg:defs").selectAll("marker")
    .data(["end"])      // Different link/path types can be defined here
  .enter().append("svg:marker")    // This section adds in the arrows
    .attr("id", String)
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 15)
    .attr("refY", -1.5)
    .attr("markerWidth", 6)
    .attr("markerHeight", 6)
    .attr("orient", "auto")
  .append("svg:path")
    .attr("d", "M0,-5L10,0L0,5");







d3.json("heads_taxonomy.json", function(error, flare) {
  root = flare;
  root.x0 = height / 2;
  root.y0 = 0;





  select2Data = [];
  selectData(root);
  select2DataObject = [];
  select2Data.sort(function(a, b) {
            if (a > b) return 1; // sort
            if (a < b) return -1;
            return 0;
        })
        .filter(function(item, i, ar) {
            return ar.indexOf(item) === i;
        }) // remove duplicate items
        .filter(function(item, i, ar) {
            select2DataObject.push({
                "id": i,
                "text": item
            });
        });
  $("#searchName").select2({
        data: select2DataObject,
        containerCssClass: "search"
  });

  function collapse(d) {
    if (d.children) {
      d._children = d.children;
      d._children.forEach(collapse);
      d.children = null;
    }
  }

  root.children.forEach(collapse);
  update(root);
});

d3.select(self.frameElement).style("height", "600px");

function update(source) {

  // Compute the new tree layout.
  var nodes = tree.nodes(root).reverse(),
      links = tree.links(nodes);

  // Normalize for fixed-depth.
  nodes.forEach(function(d) { d.y = d.depth * 180; });

  // Update the nodes�
  var node = svg.selectAll("g.node")
      .data(nodes, function(d) { return d.id || (d.id = ++i); });

  // Enter any new nodes at the parent's previous position.
  var nodeEnter = node.enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
      .on("click", toggle);

  nodeEnter.append("circle")
      .attr("r", 1e-6)
      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

  nodeEnter.append("text")
      .attr("x", function(d) { return d.children || d._children ? -10 : 10; })
      .attr("dy", ".35em")
      .attr("text-anchor", function(d) { return d.children || d._children ? "end" : "start"; })
      .text(function(d) { return d.category; })
      .style("fill-opacity", 1e-6);

  // Transition nodes to their new position.
  var nodeUpdate = node.transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

  nodeUpdate.select("circle")
      .attr("r", 4.5)
      .style("fill", function(d) {
            if (d.class === "found") {
                return "#ff4136"; //red
            } else if (d._children) {
                return "lightsteelblue";
            } else {
                return "#fff";
            }
        })
        .style("stroke", function(d) {
            if (d.class === "found") {
                return "#ff4136"; //red
            }
        });

  nodeUpdate.select("text")
      .style("fill-opacity", 1);

  // Transition exiting nodes to the parent's new position.
  var nodeExit = node.exit().transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
      .remove();

  nodeExit.select("circle")
      .attr("r", 1e-6);

  nodeExit.select("text")
      .style("fill-opacity", 1e-6);

  // Links update
  var link = svg.selectAll("path.link")
      .data(links, function(d) { return d.target.id; });

  // Adding new links at the parent's previous position.
  link.enter().insert("path", "g")
      .attr("class", "link").attr("marker-end", "url(#end)")
      .attr("d", function(d) {
        var o = {x: source.x0, y: source.y0};
        return diagonal({source: o, target: o});
      });

  // Link's transition to the new position.
  link.transition()
      .duration(duration)
      .attr("d", diagonal)
      .style("stroke", function(d) {
            if (d.target.class === "found") {
                return "#ff4136";
            }
        });

  link.exit().transition()
      .duration(duration)
      .attr("d", function(d) {
        var o = {x: source.x, y: source.y};
        return diagonal({source: o, target: o});
      })
      .remove();

  // Store the old positions for transition.
  nodes.forEach(function(d) {
    d.x0 = d.x;
    d.y0 = d.y;
  });
}

</script>

</body>

