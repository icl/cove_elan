//reassociate annotations with tiers
//
(function( $ ) {
  $.fn.DocViz = function( annotations, tiers) {
 var margin = {top: 10, right: 10, bottom: 100, left: 40},
    margin2 = {top: 430, right: 10, bottom: 20, left: 40},
    width = 640 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom,
    height2 = 500 - margin2.top - margin2.bottom;

var formatDate = d3.time.format("%b %Y");

var x = d3.scale.linear().range([0, width]),
    x2 = d3.scale.linear().range([0, width]),
    y = d3.scale.linear().range([height, 0]),
    y2 = d3.scale.linear().range([height2, 0]);

var xAxis = d3.svg.axis().scale(x).orient("bottom"),
    xAxis2 = d3.svg.axis().scale(x2).orient("bottom"),
    yAxis = d3.svg.axis().scale(y).orient("left");

var brush = d3.svg.brush()
    .x(x2)
    .on("brush", brush);



var svg = d3.select("#viewer").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom);

svg.append("defs").append("clipPath")
    .attr("id", "clip")
  .append("rect")
    .attr("width", width)
    .attr("height", height);

var focus = svg.append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var context = svg.append("g")
    .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");

  x.domain(d3.extent(annotations.map(function(d) { return d.ts_ref1; })));
  y.domain([0, d3.max(tiers.map(function(d, i) { return i; }))]);
  x2.domain(x.domain());
  y2.domain(y.domain());


    var tiers_with_annotations = _.map(tiers, function(tier) { 
      tier.annotations = _.filter(annotations, function(anno) 
                                  { return anno.tier_id == tier.id})
      return tier;
    });

     var time_start = _.min(annotations, function(anno) { return anno.ts_ref1 }).ts_ref1;

    var tiers = focus.selectAll('g.tier')
      .data(tiers_with_annotations, function(d) { return d.id})
      .enter().append('g')
      .classed('tier', true)
      .attr('transform', function(d, i) {return "translate(" + 0 + "," + (40 + i * 20) + ")"})
      .selectAll('rect').data(function(d) { return d.annotations})
      .enter().append('rect')
      .attr('x', function(d) { return x(d.ts_ref1)})
      .attr('y', 5)
      .attr('width', function(d) { return x(d.ts_ref2 - d.ts_ref1 + time_start)})
      .attr('height', 10);

  focus.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);



      /*
  context.append("path")
      .data([data])
      .attr("d", area2);
      */

      context.selectAll('circle').data(annotations).enter().append("circle")
      .attr('cx', function(d) { return x2(d.ts_ref1) })
      .attr('cy', 40)
      .attr('r', 1);


  context.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height2 + ")")
      .call(xAxis2);

  context.append("g")
      .attr("class", "x brush")
      .call(brush)
    .selectAll("rect")
      .attr("y", -6)
      .attr("height", height2 + 7);

function brush() {
  x.domain(brush.empty() ? x2.domain() : brush.extent());

  tiers.attr('x', function(d) { return x(d.ts_ref1)})
      .attr('y', 5)
      .attr('width', function(d) { return x( d.ts_ref2) - x(d.ts_ref1)})
      .attr('height', 10);

  focus.select(".x.axis").call(xAxis);
}

  };
})( jQuery );
