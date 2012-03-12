//= require brio/models/extent
//= require brio/models/scale
//= require brio/controllers/context_detail.js
(function( $ ) {
  $.fn.conBrio = function( annotations, tiers) {
var annotationsController = Ember.ArrayController.create();

var context = Brio.Extent.create();

var detail = Brio.Extent.create();

var view_controller = Brio.ContextDetailController.create();

var width = 1180;
var height = 100;

var main_viewer = d3.select("#viewer").append('svg').attr('width', width).attr('height', height);

var display = Brio.Extent.create({start: 0, end: width});


//Scales

var context_scale = Brio.Scale.create({domain: context, range: display});
var detail_scale = Brio.Scale.create({domain: detail, range: display});

//var vertical_scale = d3.scale.linear.domain([0,100]).range([0,100]);

function zoom() {
 console.warn(d3.event.translate);

 detail.set('start', detail.get('start') - d3.event.translate[0] / d3.event.scale);
 detail.set('end', detail.get('end') - d3.event.translate[0] / d3.event.scale);

 timeAxis.scale(detail_scale.get('scale'));
 main_viewer.select(".x.axis").call(timeAxis);
 console.warn("boom" + detail.get('start'));
 console.warn("dscale " + detail_scale.get('scale')(4));
}
//Context View

detail.set('start', 0);
detail.set('end', 1180);
//Axis

var test_scale = d3.scale.linear().domain([0,100000]).range([0,1180]);
//zoom
var zoomer = d3.behavior.zoom().x(test_scale).scaleExtent([1, 8]).on('zoom',zoom);

var timeAxis = d3.svg.axis().scale(detail_scale.get('scale'));

//ScaleView
var scale_view = main_viewer.append('g').attr('class', 'x axis').call(timeAxis);

main_viewer
        .call(zoomer);
//Detail View
//
  }
})( jQuery );
