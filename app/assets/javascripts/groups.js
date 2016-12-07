$(function() {
  function buildHTML(message) {
    var html = $(`<li><div class="chat__main--body--block"><div class="chat__main--body--block--name">${message.user_name}</div><div class="chat__main--body--block--date">${message.created_at}</div></div><p class="chat__main--body--message">${message.body}</p></li>`);
    return html;
  }
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#chat__main--footer--text-js');
    var body = textField.val();
    var path_elements = window.location.pathname.split("/");
    var group_id = Number(path_elements[path_elements.length - 1]);
    $.ajax({
      type: 'POST',
      url: '/chats.json',
      data: {
        message: {
          body: body,
          group_id: group_id
        }
      },
      dataType: 'json'
    })
     .done(function(data) {
       var html = buildHTML(data);
       $('.chat__main--body--list').append(html);
       textField.val('');
     })
     .fail(function() {
       alert("メッセージを入力してください");
     });
  });
});
