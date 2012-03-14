Brio.ContextView = Ember.Object.extend({
  init: function() {
    this._super()
    var self = this;
      

     self.set('view', self.get('parentView').append('g')
                                            .attr('class', 'context_view'));

     self.set('brush', d3.svg.brush()
                             .x(self.getPath('controller.context_x_scale'))
                             .on('brush', function() { 
                                self.get('controller').receive_brush()})); 
       //.attr("transform", "translate(0," + 500 + ")"));

     self.set('axis', d3.svg.axis().scale(view_controller.get('context_x_scale')));


     self.set('axis_view', self.get('view').append('g').attr('class', 'context axis'));

      self.get('view').selectAll('rect.annotation').data(self.getPath('controller.annotations',
                                                                      function(d) {return d.id})).enter()
          .append('rect')
          .attr('class', 'annotation')
          .attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)})
          .attr('y', 5)
          .attr('height', 5)
          .attr('width', 5)
          .attr('fill', 'gray');


      self.get('view').append('g')
      .attr('class', 'brush')
      .call( self.get('brush'))
      .selectAll('rect')
      .attr('height', 20);

    self.update();
  },

  update: function() {
    var self = this;
    this.get('brush').extent(this.getPath('controller.detail_x_scale').domain());

    self.get('view').select('g.brush').call(self.get('brush'));
    self.get('axis_view').call(self.get('axis'));
    self.get('view').select('rect.detail-area')
                    .attr('x', self.getPath('controller.detail_extent_in_context')[0])
                    .attr('width', function() { 
                          return self.getPath('controller.detail_extent_in_context')[1] - 
                          self.getPath('controller.detail_extent_in_context')[0]})
  }

})
