d3.select('body').append('svg').attr('width', 1050).attr('height', 50).append("circle").attr('cx', 25)
.attr('cy', 25).attr('r', 25).style('fill', 'purple')

someData = [{"class_id":777999, "count":11,"school_id":93740362,"date":"2014-06-22"},
  {"class_id":777999, "count":41,"school_id":93740362,"date":"2014-06-23"},
  {"class_id":777999, "count":23,"school_id":93740362,"date":"2014-06-24"},
  {"class_id":777999, "count":46,"school_id":93740362,"date":"2014-06-25"},
  {"class_id":777999, "count":12,"school_id":93740362,"date":"2014-06-26"},
  {"class_id":777999, "count":24,"school_id":93740362,"date":"2014-06-27"},
  {"class_id":777999,  "count":49,"school_id":93740362,"date":"2014-06-28"},
  {"class_id":777999, "count":50,"school_id":93740362,"date":"2014-06-29"}]
p = d3.select('.image').selectAll('p').data(someData).enter().append('p').text((d) -> d.class_id)

width = 1000
offset = 50
svg = d3.select('.image').append('svg').attr('width', width).attr('height', 200)

headCount =
  777999: 50
  777666: 50
  777888: 50

days = [9..1].map (d) ->
  a = new Date()
  a.setDate(a.getDate() - d)
  a.getFullYear() + '-' + ('0' + (a.getMonth() + 1)).slice(-2) + '-' + ('0' + a.getDate()).slice(-2)
daysMap = _.object([0..8], days)

x = d3.scale.ordinal().rangeRoundBands([0, width], .1, 0);
x.domain(days)
xAxis = d3.svg.axis().scale(x).orient("bottom")
svg.append('g').attr("class", "axis x").attr("transform", "translate(0,180)").call(xAxis)

bars = svg.selectAll('rect').data(someData).enter()
bars.append('rect').attr('x', (d) -> x(d.date) + offset).attr('height', (d) -> (d.count*1.0 / headCount[d.class_id])* 180)
.attr('y', (d) -> (1 - (d.count*1.0 / headCount[d.class_id]))*180).attr('width', 20)
.style('fill', 'green')

bars.append('rect').attr('x', (d) -> x(d.date) + offset).attr('height', (d) -> (1 - (d.count*1.0 / headCount[d.class_id]))*180)
.attr('y', 0).attr('width', 20)
.style('fill', 'red')

bars.append("text").attr('width', 200).attr('height', 100).attr('x', (d) ->
  x(d.date) + offset + 20).attr('y', 20).text((d) -> headCount[d.class_id] - d.count)
bars.append("text").attr('width', 200).attr('height', 100).attr('x', (d) ->
  x(d.date) + offset + 20).attr('y', 160).text((d) -> d.count)

svg.append("text").attr('width', 200).attr('height', 100).attr('x', 20)
.attr('y', 20).text('缺席')

svg.append("text").attr('width', 200).attr('height', 100).attr('x', 20)
.attr('y', 160).text('实到')







