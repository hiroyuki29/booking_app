$(document).on('turbolinks:load', function() {
  $("#room-price").tooltip({
      title: "数値を入れてください",
      trigger: "manual"
    })
    .keypress(function(e) {
      if (e.which && e.which === 13) {
        let value = $(this).val();
        if (!Number.isFinite(Number(value))) {
          $(this).tooltip('show'); // Tooltipを表示する
          return false;
        }
      }
    })
    .on('shown.bs.tooltip', function() {
      setTimeout((function() {
        $(this).tooltip('hide');
      }).bind(this), 2000);
    });
});
