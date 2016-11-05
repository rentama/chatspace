$(function() {
  $(".chat__main--footer--block__right").on("click", function() {
    if ($("#chat__main--footer--text-js").val() === "")　{
      window.alert("メッセージを入力してください");
    };
  });
});
