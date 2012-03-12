#= require jquery
#= require d3.v2
#= require underscore
#= require document_viewer


describe "Document Viewer", ->
  it "is a jquery plugin", ->
    expect($().DocViz).toBeTruthy()

  it "accepts annotations and tiers as arguments", ->
    annotations = [{"ts_ref1": 0, "ts_ref2": 1 }]
    tiers = [{"id":5}]
    $().DocViz(annotations, tiers)
    $('#viewer').remove()


  it "it offsets the first tier by 40", ->
    $('body').append('<div id="viewer"></div>')
    annotations = [{"ts_ref1": 0, "ts_ref2": 1 }]
    tiers = [{"id":5}]
    $().DocViz(annotations, tiers)
    expect($($('#viewer g')[0]).attr('transform')).toEqual("translate(40,10)")
    $('#viewer').remove()

  it "it offsets the later tiers by 20 each", ->
    $('body').append('<div id="viewer"></div>')
    annotations = [{"ts_ref1": 0, "ts_ref2": 1 }]
    tiers = [{"id":5}, {"id":7},{"id":256}]
    $().DocViz(annotations, tiers)
    expect($($('#viewer g')[2]).attr('transform')).toEqual("translate(0,60)")
    $('#viewer').remove()

    

