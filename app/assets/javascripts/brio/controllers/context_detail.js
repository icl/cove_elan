Brio.ContextDetailController = Ember.Object.extend({
 detail_extent_in_context: function() {
    return [this.get('context_x_scale')(this.get('detail_x_scale').domain()[0]),
            this.get('context_x_scale')(this.get('detail_x_scale').domain()[1])]

 }.property(),

 receive_zoom: function() {
    this.adjust_extents();
 },
 adjust_extents: function() {
    this.get('detail_view').update();
    this.get('context_view').update();
  }


 }
)
