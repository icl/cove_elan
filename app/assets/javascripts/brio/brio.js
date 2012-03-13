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
 annotations: annotations,
 tiers: tiers
});
window.view_controller = view_controller;

main_view = d3.select("#viewer").append('svg').attr('width', width).attr('height', height),



view_controller.set('main_view', main_view);
view_controller.set('detail_view', 
                    Brio.DetailView.create({controller:view_controller, parentView: main_view}));

view_controller.set('context_view',
                    Brio.ContextView.create({controller:view_controller, parentView: main_view}));


//ScaleView




  }


})( jQuery );
