Brio.ContextDetailController = Ember.Object.extend({

 detail_extent_in_context: function() {
    return [this.get('context_x_scale')(this.get('detail_x_scale').domain()[0]),
            this.get('context_x_scale')(this.get('detail_x_scale').domain()[1])]

 }.property()
})
