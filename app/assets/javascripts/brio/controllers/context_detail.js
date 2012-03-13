Brio.ContextDetailController = Ember.Object.extend({
 detail_extent_in_context: function() {
    return [this.get('context_x_scale')(this.get('detail_x_scale').domain()[0]),
            this.get('context_x_scale')(this.get('detail_x_scale').domain()[1])]

 }.property(),

 receive_zoom: function() {
    this.adjust_extents();
 },
 adjust_extents: function() {
   var self = this;
   var bur = d3.svg.axis().scale(self.get('detail_x_scale'));

    this.get('main_view').select(".detail.axis").call(bur);
    this.get('main_view').select('rect.detail-area')
           .attr('x', function() { return self.get('detail_extent_in_context')[0]})
           .attr('width', function() { 
             return self.get('detail_extent_in_context')[1] - 
               self.get('detail_extent_in_context')[0]});

    this.get('detail_view').get('update');

  }


 }
)
