$(function() {
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
       $('.chat__main--body--list').append(`<li><div class="chat__main--body--block"><div class="chat__main--body--block--name">${data.user_name}</div><div class="chat__main--body--block--date">${data.created_at}</div></div><p class="chat__main--body--message">${data.body}</p></li>`);
       textField.val('');
     })
     .fail(function() {
       alert("メッセージを入力してください");
     });
  });
});
