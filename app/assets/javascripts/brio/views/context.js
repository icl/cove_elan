Brio.ContextView = Ember.Object.extend({
  init: function() {
    this._super()
    var self = this;

     self.set('view', self.get('parentView').append('g')
                                            .attr('class', 'context axis'));
                                            //.attr("transform", "translate(0," + 500 + ")"));

     self.set('axis', d3.svg.axis().scale(view_controller.get('context_x_scale')));


     self.set('axis_view', self.get('view').append('g').attr('class', 'context axis'));


     self.set('detail_in_context', self.get('view').append('rect')
           .attr('class', 'detail-area')
           .attr('x', function() { return self.getPath('controller.detail_extent_in_context')[0]})
           .attr('y', 0)
           .attr('height', 20)
           .attr('stroke', 'black')
           .attr('fill', 'blue')
           .attr('fill-opacity', 0.2)
           .attr('width', function() { 
             return self.getPath('controller.detail_extent_in_context')[1] - 
               self.getPath('controller.detail_extent_in_context')[0]}));





      self.get('view').selectAll('rect.annotation').data(self.getPath('controller.annotations',
                                                                      function(d) {return d.id})).enter()
          .append('rect')
          .attr('class', 'annotation')
          .attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)})
          .attr('y', 5)
          .attr('height', 5)
          .attr('width', 5)
          .attr('stroke', 'blue');

    self.update();
  },

  update: function() {
    var self = this;
    self.get('axis_view').call(self.get('axis'));
    self.get('view').select('rect.detail-area')
                    .attr('x', self.getPath('controller.detail_extent_in_context')[0])
                    .attr('width', function() { 
                          return self.getPath('controller.detail_extent_in_context')[1] - 
                          self.getPath('controller.detail_extent_in_context')[0]})
  }

})
