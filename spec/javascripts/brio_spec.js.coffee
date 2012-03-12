#= require jquery
#= require d3.v2
#= require ember
#= require brio/app


describe "Brio", ->
  describe "Extent", ->
    it "has a start time", ->
      expect(
        Brio.Extent.create({
          start: 50 })
        .get('start')).toEqual(50)

    it "has an end time", ->
      expect(
        Brio.Extent.create({
        end:78 })
        .get('end')).toEqual(78)

    it "can provide an extent", ->
      expect(
        Brio.Extent.create({
          start: 40,
          end: 50})
        .get('extent')).toEqual([40,50])

    it "should update the extent when the start changes", ->
      expect(
        Brio.Extent.create({
          start: 90,
          end: 50
        })
        .get('extent')).toEqual([50, 90])

    it "should update the extent when the end changes", ->
      expect(
        Brio.Extent.create({
          start:40,
          end: 180
        }).get('extent')).toEqual([40, 180])

  describe "Scale", ->
    it "has a domain", ->
      expect( Brio.Scale.create({
        domain: Brio.Extent.create({start: 4, end:10})
      }).getPath('domain.extent')).toEqual([4,10])
    it "has a range", ->
      expect( Brio.Scale.create({
        range: Brio.Extent.create({start: 0, end:1})
      }).getPath('range.extent')).toEqual([0,1])
    it "scales values based on its domain and range", -> 
      expect( Brio.Scale.create({
        domain: Brio.Extent.create({start: 50, end:100}),
        range: Brio.Extent.create({start: 0, end:1})
      }).get('scale')(75))
        .toEqual(0.5)

    it "will update when underlying extents change", ->
      s =  Brio.Scale.create({
        domain: Brio.Extent.create({start: 50, end:100}),
        range: Brio.Extent.create({start: 0, end:1})
      })

      s.setPath('domain.start', 0)
      expect(s.get('scale')(75)).toEqual(0.75)
