$(document).on('turbolinks:load', function() {
  $(".email-check").keypress(function(e) {
      if (e.which && e.which === 13) {
        let value = $(this).val();
        if (!value.includes("@")) {
          $(this).tooltip('show'); // Tooltipを表示する
          return false;
        }
      }
    })
    .tooltip({
      title: "@がありません",
      trigger: "manual"
    })
    .on('shown.bs.tooltip', function() {
      setTimeout((function() {
        $(this).tooltip('hide');
      }).bind(this), 2000);
    });
});


$(document).on('turbolinks:load', function() {
  $(".submit-check").click(function() {
        let value = $(".email-check").val();
        if (!value.includes("@")) {
          $(".email-check").tooltip('show'); // Tooltipを表示する
          return false;
        }
    })
    .tooltip({
      title: "@がありません",
      trigger: "manual"
    })
    .on('shown.bs.tooltip', function() {
      setTimeout((function() {
        $(".email-check").tooltip('hide');
      }).bind(".email-check"), 2000);
    });
});
