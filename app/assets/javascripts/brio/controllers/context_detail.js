Brio.ContextDetailController = Ember.Object.extend({
 detail_extent_in_context: function() {
    return [this.get('context_x_scale')(this.get('detail_x_scale').domain()[0]),
            this.get('context_x_scale')(this.get('detail_x_scale').domain()[1])]

 }.property(),

 receive_zoom: function() {
    this.getPath('context_view.brush').extent(this.get('detail_x_scale').domain());
    this.adjust_extents();
 },
 receive_brush: function(){
   
   this.get('detail_x_scale').domain(
    this.getPath('context_view.brush').empty() ? this.getPath('context_x_scale').domain() : this.getPath('context_view.brush').extent()
 );
    
   
   this.adjust_extents();
 },
 adjust_extents: function() {
    this.get('detail_view').update();
    this.get('context_view').update();
  }


 }
)
