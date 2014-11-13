$(function(){

  var $tables = $('[data-behavior=tablednd]');

  $tables.each(function(){
    var $table = $(this);
    $table.find("thead tr").append("<th></th>");
    $table.find("tbody tr").append('<td class=text-center data-behavior=draghandle><i class="glyphicon glyphicon-move"></i></td>');
  });

  $tables.tableDnD({
    onDrop: function(table, row) {
      var $table = $(table), data = {};
      $table.find("tbody tr").each(function(i, row){
        data[$(row).data('row-id')] = i;
      });
      $.post($table.data().reorderUrl, {positions: data});
    },
    dragHandle: "[data-behavior=draghandle]"
  });

});
