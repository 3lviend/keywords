$(function() {
    $( "#from" ).datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#to" ).datepicker({ dateFormat: 'yy-mm-dd' });
});

window.onload = function () {

  var chart = new CanvasJS.Chart("chartContainer",
  {
    title:{
    text: ""   
    },
    animationEnabled: true,
    axisX:{
      title: "Date"
    },
    axisY:{
      title: "Keywords"
    },
    axisY:{
       interval: 8
     },
    data: [
    {        
      type: "stackedColumn100",
      name: "Sample 1",
      showInLegend: "true",
      dataPoints: [
      {  y: 10, label: "Apr 05"},
      {  y: 10, label: "Apr 12" },
              
      ]
    }, {        
      type: "stackedColumn100",        
      name: "Sample 2",
      showInLegend: "true",
      dataPoints: [
      {  y: 10, label: "Apr 05"},
      {  y: 14, label: "Apr 12" },
               
      ]
    },
     {        
      type: "stackedColumn100",        
      name: "Sample 3",
      showInLegend: "true",
      dataPoints: [
      {  y: 20, label: "Apr 05"},
      {  y: 14, label: "Apr 12" },
              
      ]
    }

    ],  
  });

  chart.render();
}
$(window).ready(function(){
  if (window.location.pathname == "/select_date") {
      $(".back-page").addClass("show");
  }else{
      $(".back-page").removeClass("show");
  }
});
