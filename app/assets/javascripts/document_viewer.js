//reassociate annotations with tiers
//
(function( $ ) {
  $.fn.DocViz = function( annotations, tiers) {
    var tiers_with_annotations = _.map(tiers, function(tier) { 
      tier.annotations = _.filter(annotations, function(anno) 
                                  { return anno.tier_id == tier.id})
      return tier;
    });

    var width = 940;
    var height = 500;
    var time_start = _.min(annotations, function(anno) { return anno.ts_ref1 }).ts_ref1;
    var time_end = _.max(annotations, function(anno) { return anno.ts_ref2}).ts_ref2;


    var time_scale = d3.scale.linear().domain([time_start, time_end]).range([0, width]);

    window.ts = time_scale;

    var annotations_view = d3
      .select("#viewer")
      .append('svg')
      .attr('width', width)
      .attr('height', height);

    var annotations = annotations_view
      .selectAll('circle')
      .data(annotations)
      .enter().append('circle')
      .attr('cx', function(d) { return time_scale(d.ts_ref1)})
      .attr('cy', 40)
      .attr('r', 1);


    var tiers = annotations_view.selectAll('g.tier')
      .data(tiers_with_annotations, function(d) { return d.id})
      .enter().append('g')
      .classed('tier', true)
      .attr('transform', function(d, i) {return "translate(" + 0 + "," + (40 + i * 20) + ")"})
      .selectAll('rect').data(function(d) { return d.annotations})
      .enter().append('rect')
      .attr('x', function(d) { return time_scale(d.ts_ref1)})
      .attr('y', 5)
      .attr('width', function(d) { return time_scale(d.ts_ref2 - d.ts_ref1 + time_start)})
      .attr('height', 10);

  return $(annotations_view);
  };
})( jQuery );
