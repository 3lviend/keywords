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


$(document).ready(function(){
  // $(function)() {
function getFrom(){
  $( "#from" ).datepick({
     dateFormat: 'yyyy-mm-dd', 
     rangeSelect: true,
     showTrigger: '#calImg',
     onClose: function(){
     // onSelect: function(){
     // onChangeMonthYear: function(){
      var date = new Date($('#from').datepick('getDate')[1].getTime()); 
      date = $.datepick.add(date, 1, "d");
      $( "#to" ).datepick({
         dateFormat: 'yyyy-mm-dd',
         minDate: date,
         rangeSelect: true,
         showTrigger: '#calImg'
      });
     }
  });

  // $('#setDay,#setMonth,#setYear').change(function() { 
  //       var date = $.datepick.day( 
  //           $.datepick.month( 
  //               $.datepick.year( 
  //                   $.datepick.today(), $('#setYear').val()), 
  //               $('#setMonth').val()), 
  //           $('#setDay').val()); 
  //       $('#setDate').val($.datepick.formatDate(date)); 
  //   }). 
  //   change();

  // $('#from').change(function(){
  //   alert
  // });

// $( "#from" ).datepick({
//      onChangeMonthYear: function(){
//       var date = new Date($('#from').datepick('getDate')[1].getTime()); 
//       date = $.datepick.add(date, 1, "d");
//       $( "#to" ).datepick({
//          dateFormat: 'yy-mm-dd',
//          minDate: date,
//          rangeSelect: true,
//          showTrigger: '#calImg'
//       });
//      }
//    });

}


// function getTo(){
//   dates = $("#from").val().split(" ")[2];
//   console.log(dates);
//   $( "#to" ).datepick({
//      dateFormat: 'yy-mm-dd',
//      minDate: dates,
//      rangeSelect: true,
//      showTrigger: '#calImg'
//   });
// }

// $(document).ready(function(){
// $( "#from" ).focus(function(){
  getFrom();
// })
});

// $('#onSelectPicker').datepick({ 
//     onSelect: function(dates) { alert('The chosen date(s): ' + dates); }, 
//     showTrigger: '#calImg'});

$(window).ready(function(){

  if (window.location.pathname == "/select_date") {
      $(".back-page").addClass("show");
  }else{
      $(".back-page").removeClass("show");
  }

});
