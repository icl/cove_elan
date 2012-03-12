Brio.Scale = Ember.Object.extend({
  init: function(){
    this.set('linearScale', d3.scale.linear());
  },
  scale: function(){
   return this.get('linearScale')
          .domain(this.getPath('domain.extent'))
          .range(this.getPath('range.extent'));
  }.property('domain.extent', 'range.extent'),

  
});
