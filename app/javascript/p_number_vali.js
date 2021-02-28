$(document).on('turbolinks:load', function() {
  $("#p-number-form").keypress(function(e) {
      if (e.which && e.which === 13) {
        let value = $(this).val();
        if (!Number.isFinite(Number(value))) {
          $(this).tooltip('show'); // Tooltipを表示する
          return false;
        }
      }
    })
    .tooltip({
      title: "数値を入れてください",
      trigger: "manual"
    })
    .on('shown.bs.tooltip', function() {
      setTimeout((function() {
        $(this).tooltip('hide');
      }).bind(this), 2000);
    });
});
