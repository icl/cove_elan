Brio.DetailView = Ember.Object.extend({

  update: function(){
    var self = this;
  var zoomer = d3.behavior.zoom().x(view_controller.get('detail_x_scale'))
  .on('zoom',function() {view_controller.receive_zoom()});

  var detail_view = self.get('parentView').selectAll('g.detail-view').data([1]).enter().append('g')
  .attr('class', 'detail-view').attr("transform", "translate(0," + 80 + ")")

  detail_view.call(zoomer);
  var bur = d3.svg.axis().scale(view_controller.get('detail_x_scale'));
  var detail_scale_view = detail_view.append('g').attr('class', 'detail axis')
  .call(bur);

  detail_view.append('rect').attr('x', 0).attr('y', 20).attr('width', 1180).attr('height', 300)

  annos = detail_view.selectAll('rect.annotation').data(self.getPath('controller.annotations'))

  annos.attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)});
 
  annos.enter()
  .append('rect')
  .attr('class', 'annotation')
  .attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)})
  .attr('y', 5)
  .attr('height', 5)
  .attr('width', 5)
  .attr('stroke', 'blue');

  annos.exit().remove();


  }.property('controller.scale', 'data')
})
