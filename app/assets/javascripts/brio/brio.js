//= require brio/models/extent
//= require brio/models/scale
//= require brio/controllers/context_detail.js
(function( $ ) {
  $.fn.conBrio = function( annotations, tiers) {
var annotationsController = Ember.ArrayController.create();

var view_controller = Brio.ContextDetailController.create();

var width = 1180;
var height = 100;

var main_viewer = d3.select("#viewer").append('svg').attr('width', width).attr('height', height);

//Scales


view_controller.set('detail_x_scale', d3.scale.linear().domain([0,100]).range([0,1180]));
view_controller.set('context_x_scale', d3.scale.linear().domain([0,100]).range([0,1180]));


//var vertical_scale = d3.scale.linear.domain([0,100]).range([0,100]);

function zoom() {



 main_viewer.select(".detail.axis").call(detailAxis);


}

//Axis

//zoom
var zoomer = d3.behavior.zoom().x(view_controller.get('detail_x_scale')).scaleExtent([1, 8]).on('zoom',zoom);

var detailAxis = d3.svg.axis().scale(view_controller.get('detail_x_scale'));

var contextAxis = d3.svg.axis().scale(view_controller.get('context_x_scale'));

//ScaleView


var detail_scale_view = main_viewer.append('g').attr('class', 'detail axis').call(detailAxis);
var detail_scale_view = main_viewer.append('g')
                                   .attr('class', 'context axis')
                                   .attr("transform", "translate(0," + 40 + ")")
                                   .call(contextAxis);


main_viewer
        .call(zoomer);
//Detail View
//
  }
})( jQuery );
