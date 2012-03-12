//= require brio/models/extent
//= require brio/models/scale
//= require brio/controllers/context_detail.js
(function( $ ) {
  $.fn.conBrio = function( annotations, tiers) {
var annotationsController = Ember.ArrayController.create();

var view_controller = Brio.ContextDetailController.create();

var width = 1180;
var height = 400;

var main_viewer = d3.select("#viewer").append('svg').attr('width', width).attr('height', height);

//Scales


view_controller.set('detail_x_scale', d3.scale.linear().domain([0,1000]).range([0,1180]));
view_controller.set('context_x_scale', d3.scale.linear().domain([0,1000]).range([0,1180]));

function zoom() {

 main_viewer.select(".detail.axis").call(detailAxis);
 main_viewer.select('rect.detail-area')
           .attr('x', function() { return view_controller.get('detail_extent_in_context')[0]})
           .attr('width', function() { 
             return view_controller.get('detail_extent_in_context')[1] - 
               view_controller.get('detail_extent_in_context')[0]});
}

//Axis

//zoom
var zoomer = d3.behavior.zoom().x(view_controller.get('detail_x_scale')).scaleExtent([1,120]).on('zoom',zoom);

var detailAxis = d3.svg.axis().scale(view_controller.get('detail_x_scale'));

var contextAxis = d3.svg.axis().scale(view_controller.get('context_x_scale'));

//ScaleView


var context_scale_view = main_viewer.append('g')
                                   .attr('class', 'context axis')
                                   .attr("transform", "translate(0," + 40 + ")")
                                   .call(contextAxis);

main_viewer.append('rect')
           .attr('class', 'detail-area')
           .attr('x', function() { return view_controller.get('detail_extent_in_context')[0]})
           .attr('y', 40)
           .attr('height', 20)
           .attr('stroke', 'black')
           .attr('fill', 'none')
           .attr('width', function() { 
             return view_controller.get('detail_extent_in_context')[1] - 
               view_controller.get('detail_extent_in_context')[0]});


var detail_view = main_viewer.append('g').attr('class', 'detail-view').attr("transform", "translate(0," + 80 + ")")

detail_view.call(zoomer);

var detail_scale_view = detail_view.append('g').attr('class', 'detail axis').call(detailAxis);

detail_view.append('rect').attr('x', 0).attr('y', 20).attr('width', 1180).attr('height', 300)
//
  }
})( jQuery );
