function setPie(){
    var dataSet=[34,32,24,15,10,5];
    var color = d3.scale.category20();
    var pie = d3.layout.pie();

    var arc = d3.svg.arc().innerRadius(40).outerRadius(80);

    var pieElements = d3.select("#chart")
              .selectAll("g")
              .data(pie(dataSet))
              .enter()
              .append("g")
              .attr("transform","translate(80,80)");



    pieElements
    .append("path")
    .attr("class","pie")
    .style("fill",function(d,i){
    	return ["#aa00ff","#1ba0e1","#765f89","#7ad61d","#01abaa","#ff2d1a"][i];
    })
    .transition()
    .duration(500)
    .delay(function(d,i){
    	return i*500;
    })
    .ease("line")
    .attrTween("d", function(d, i){	// 補間処理をする
		var interpolate = d3.interpolate(
			{ startAngle : d.startAngle, endAngle : d.startAngle }, // 各部分の開始角度
			{ startAngle : d.startAngle, endAngle : d.endAngle }    // 各部分の終了角度
       	 );
		return function(t){
			return arc(interpolate(t)); // 時間tに応じて処理
		}
	});

    var textElements = d3.select("#chart").append("text")
    					 .attr("class","total")
    					 .attr("transform","translate(45,80)")
    					 .text("合計：" + d3.sum(dataSet))
    					 .style("font-size","15px");

    pieElements
    .append("text")
    .attr("class","pieNum")
    .attr("transform",function(d,i){
    	return "translate("+arc.centroid(d)+")";
    })
    .text(function(d,i){
    	return d.value;
    });






}
