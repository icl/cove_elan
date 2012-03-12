Brio.Extent = Ember.Object.extend( {
  extent: function () {
    return d3.extent([this.get('start'), this.get('end')]);
  }.property('start', 'end')
});

