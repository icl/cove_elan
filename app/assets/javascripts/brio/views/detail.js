Brio.DetailView = Ember.Object.extend({
  init: function() {
    this._super();
    var self = this;
    self.set('view', this.get('parentView').append('g')
        .attr('class', 'detail-view').attr("transform", "translate(0," + 80 + ")"));
    self.set('zoom',  d3.behavior.zoom().x(self.getPath('controller.detail_x_scale')).scaleExtent([1,200])
                                 .on('zoom',function() {self.get('controller').receive_zoom()}));
    
    self.set('axis', d3.svg.axis().scale(self.getPath('controller.detail_x_scale')));

    self.set('detail_scale_view', self.get('view').append('g').attr('class', 'detail axis'));
  
    self.get('view').append('rect').attr('x', 0)
    .attr('y', 20).attr('width', 1180).attr('height', 300).attr('fill', 'white');

    self.update();

     self.set('tiers_with_annotations', 
            _.map(self.getPath('controller.tiers')
                               ,function(tier) { 
                                tier.annotations = _.filter(self.getPath('controller.annotations'), function(anno) 
                                  { return anno.tier_id == tier.id})
      return tier;
    }));


  },
  update: function(){
    var self = this;

    self.get('view').call(self.get('zoom'));
    self.get('detail_scale_view').call(self.get('axis'));

    

    var tiers = self.get('view').selectAll('g.tier')
            .data(self.getPath('controller.tiers'), function(d) {return d.id});
            
        tiers.enter().append('g').attr('class', 'tier')
            .attr("transform", function(d,i){ return "translate(0," + (30 + (30 * i)) + ")"})            .append('text').attr('x', 20)
            .attr('y',12)
            .text(function(d){ return d.tier_id});

    var annos = tiers.selectAll('rect.annotation')
                .data(function(d) {return d.annotations = _.filter(self.getPath('controller.annotations'), function(anno) 
                                  { return anno.tier_id == d.id})}, function(d){ return d.id});

    annos.attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)}) 
    .attr('width', function(d){ return self.getPath('controller.detail_x_scale')(d.ts_ref2) - 
                                       self.getPath('controller.detail_x_scale')(d.ts_ref1)});
    self.get('view').selectAll('rect.annotation').attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)}) 
    .attr('width', function(d){ return self.getPath('controller.detail_x_scale')(d.ts_ref2) - 
                                       self.getPath('controller.detail_x_scale')(d.ts_ref1)});

    annos.enter()
    .append('rect')
    .attr('class', 'annotation')
    .attr('x', function(d) { return self.getPath('controller.detail_x_scale')(d.ts_ref1)})
    .attr('y', 5)
    .attr('height', 10)
    .attr('width', function(d){ return self.getPath('controller.detail_x_scale')(d.ts_ref2 - d.ts_ref1)})
    .attr('fill', '#28313E')
    .attr('stroke', '#50678D'); 

    //annos.append();
  }
})
