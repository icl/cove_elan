//= require brio/models/extent
//= require brio/models/scale
//= require brio/controllers/context_detail.js

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

context.set('start', 0);
context.set('end', 100);
console.warn(context);
console.warn(display);

console.warn(context_scale.get('scale')(50));

detail.set('start', 50);
detail.set('end', 100);

console.warn(detail_scale.get('scale')(50));

//zoom

//Context View

//ScaleView



//Detail View
