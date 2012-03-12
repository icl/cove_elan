//reassociate annotations with tiers
//
(function( $ ) {
  $.fn.AnnotationOverlap = function(annotations, viewer_index) {

    /* Create an array of overlapping annotations */
    annotation_arr = annotations.toString().split(',');
    
    /* Init our chart */
    var chart = d3.select("#viewer_"+viewer_index).append("svg")
      .attr("class", "chart")
      .attr("width", 940)
      .attr("height", 60);

    /* Create our D3 Linear Scaler function */
    min = d3.min(annotation_arr);
    max = d3.max(annotation_arr);
    var scaler = d3.scale.linear().range([0,940]).domain([min, max]);

    /* Pull our overlap values out */
    x1_min = scaler(annotation_arr[0]);
    x2_min = scaler(annotation_arr[2]);

    x1_max = scaler(annotation_arr[1]);
    x2_max = scaler(annotation_arr[3]);

    /* Setup our histogram colors */
    bottom_color = 'teal';
    top_color = 'steelblue';

    /* Create our fill array for our overlapping histogram */
    var fill_array = new Array();

    if (x1_max > x2_max) {
      fill_array.push( [ x1_max, x2_min, top_color ] );
      fill_array.push( [ x2_max, x1_min, bottom_color ] );
      o_intersect = fill_array[0][0] - fill_array[1][0];
    } else {
      fill_array.push( [ x2_max, x1_min, bottom_color ] );
      fill_array.push( [ x1_max, x2_min, top_color ] );
    }

    o_intersect = fill_array[1][0] - fill_array[0][1];
    if (o_intersect == 940)
      o_intersect = fill_array[0][1] + fill_array[1][1];

    chart.selectAll("rect")
      .data(annotations)
      .enter().append("rect")
      .attr("y", function(d, i) {
        return 20 * i} )
      .style("fill", function(d,i) {
          return fill_array[i][2];
        })
      .attr("x", function(d,i) {
          return Math.round(fill_array[i][1]);
        })
      .attr("width", function(d,i) {
          return Math.round(fill_array[i][0] - fill_array[i][1]);
        })
      .attr("height", 20)

    chart.append("text")
      .attr("y", 50)
       .style("fill", '#000')
      .attr("x", function() {
        if (o_intersect > 705) {
          return o_intersect - 50;
        } else {
          return o_intersect + 5;
        }
       })
      .text(scaler.invert(o_intersect));

    chart.append("line")
      .attr("x1", o_intersect)
      .attr("x2", o_intersect)
      .attr("y1", 10)
      .attr("y2", 60)
      .style("stroke", "red");

    chart.append("line")
      .attr("x1", 0)
      .attr("x2", 0)
      .attr("y1", 0)
      .attr("y2", 60)
      .style("stroke", "#000");

    chart.append("line")
      .attr("x1", fill_array[0][0])
      .attr("x2", fill_array[0][0])
      .attr("y1", 0)
      .attr("y2", 60)
      .style("stroke", "#000");
};
})( jQuery );
