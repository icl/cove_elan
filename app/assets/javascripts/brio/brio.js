//= require brio/models/extent
//= require brio/models/scale
//= require brio/controllers/context_detail
//= require brio/views/detail

(function( $ ) {
  $.fn.conBrio = function( annotations, tiers) {
var width = 1180;
var height = 1000;


var annotationsController = Ember.ArrayController.create();

var view_controller = Brio.ContextDetailController.create({
 detail_x_scale: d3.scale.linear().domain(d3.extent([0,
                                  _.max(annotations, function(item)
                                                  {return item.ts_ref2}).ts_ref2]))
                                  .range([0,width]),
 context_x_scale:  d3.scale.linear().domain(d3.extent([0,
                                  _.max(annotations, function(item)
                                                  {return item.ts_ref2}).ts_ref2]))
                                  .range([0,width]),
 detail_axis: function(){ return d3.svg.axis().scale(this.get('detail_x_scale'))},
 annotations: annotations
});
window.view_controller = view_controller;

main_view = d3.select("#viewer").append('svg').attr('width', width).attr('height', height),



view_controller.set('main_view', main_view);
view_controller.set('detail_view', 
                    Brio.DetailView.create({controller:view_controller, parentView: main_view}));
view_controller.get('detail_view').get('update');

var contextAxis = d3.svg.axis().scale(view_controller.get('context_x_scale'));

//ScaleView


var context_scale_view = view_controller.get('main_view').append('g')
                                   .attr('class', 'context axis')
                                   .attr("transform", "translate(0," + 500 + ")")
                                   .call(contextAxis);

context_scale_view.append('rect')
           .attr('class', 'detail-area')
           .attr('x', function() { return view_controller.get('detail_extent_in_context')[0]})
           .attr('y', 10)
           .attr('height', 20)
           .attr('stroke', 'black')
           .attr('fill', 'none')
           .attr('width', function() { 
             return view_controller.get('detail_extent_in_context')[1] - 
               view_controller.get('detail_extent_in_context')[0]});





context_scale_view.selectAll('rect.annotation').data(annotations).enter()
.append('rect')
.attr('class', 'annotation')
.attr('x', function(d) { return view_controller.get('detail_x_scale')(d.ts_ref1)})
.attr('y', 5)
.attr('height', 5)
.attr('width', 5)
.attr('stroke', 'blue');



  }


})( jQuery );
