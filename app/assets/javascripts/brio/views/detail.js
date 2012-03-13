Brio.DetailView = Ember.Object.extend({
  init: function() {
    this._super();
    var self = this;
    self.set('view', this.get('parentView').append('g')
        .attr('class', 'detail-view').attr("transform", "translate(0," + 80 + ")"));
    self.set('zoom',  d3.behavior.zoom().x(self.getPath('controller.detail_x_scale'))
                                 .on('zoom',function() {self.get('controller').receive_zoom()}));
    self.set('axis', d3.svg.axis().scale(self.getPath('controller.detail_x_scale')));

    self.set('detail_scale_view', self.get('view').append('g').attr('class', 'detail axis'));

    self.update();
  },
  update: function(){
    var self = this;

    self.get('view').call(self.get('zoom'));
    self.get('detail_scale_view').call(self.get('axis'));

    self.get('view').append('rect').attr('x', 0)
    .attr('y', 20).attr('width', 1180).attr('height', 300)

    annos = self.get('view').selectAll('rect.annotation')
                                   .data(self.getPath('controller.annotations'), function(d) {return d.id})

    annos.attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)});

    annos.enter()
    .append('rect')
    .attr('class', 'annotation')
    .attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)})
    .attr('y', 5)
    .attr('height', 5)
    .attr('width', 5)
    .attr('stroke', 'blue');
  }
})
