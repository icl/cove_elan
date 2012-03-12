//= require brio/models/extent
//= require brio/models/scale
//= require brio/controllers/context_detail.js
(function( $ ) {
  $.fn.conBrio = function( annotations, tiers) {
var width = 1180;
var height = 400;


var annotationsController = Ember.ArrayController.create();

var view_controller = Brio.ContextDetailController.create({
 detail_x_scale: d3.scale.linear().domain([0,1000]).range([0,1180]),
 context_x_scale:  d3.scale.linear().domain([0,1000]).range([0,1180]),
 main_view: d3.select("#viewer").append('svg').attr('width', width).attr('height', height),
 detail_axis: function(){ return d3.svg.axis().scale(this.get('detail_x_scale'))}

});
window.view_controller = view_controller;


function zoom() {
  view_controller.receive_zoom()
}

//Axis

//zoom
var zoomer = d3.behavior.zoom().x(view_controller.get('detail_x_scale')).scaleExtent([1,120]).on('zoom',zoom);


var contextAxis = d3.svg.axis().scale(view_controller.get('context_x_scale'));

//ScaleView


var context_scale_view = view_controller.get('main_view').append('g')
                                   .attr('class', 'context axis')
                                   .attr("transform", "translate(0," + 40 + ")")
                                   .call(contextAxis);

view_controller.get('main_view').append('rect')
           .attr('class', 'detail-area')
           .attr('x', function() { return view_controller.get('detail_extent_in_context')[0]})
           .attr('y', 40)
           .attr('height', 20)
           .attr('stroke', 'black')
           .attr('fill', 'none')
           .attr('width', function() { 
             return view_controller.get('detail_extent_in_context')[1] - 
               view_controller.get('detail_extent_in_context')[0]});


var detail_view = view_controller.get('main_view').append('g')
.attr('class', 'detail-view').attr("transform", "translate(0," + 80 + ")")

detail_view.call(zoomer);

var bur =d3.svg.axis().scale(view_controller.get('detail_x_scale'));
console.warn(bur.scale());
var detail_scale_view = detail_view.append('g').attr('class', 'detail axis')
.call(bur);

detail_view.append('rect').attr('x', 0).attr('y', 20).attr('width', 1180).attr('height', 300)
//
  }
})( jQuery );
