$(function() {
  $(document).on('click', '.user-search-add', function(){
    var user_id = $(this).data('user-id');
    var user_name = $(this).data('user-name');
    var html = build_decided_user(user_id, user_name);
    $('#chat-group-user').append(html);
  });

  $(document).on('click', '.user-search-remove', function() {
    var user_id = $(this).data('user-id');
    $(`#${user_id}`).remove()
  });

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#chat__main--footer--text-js');
    // var body = textField.val();
    // var path_elements = window.location.pathname.split("/");
    // var group_id = Number(path_elements[path_elements.length - 1]);
    var fd = new FormData($('form#new_message').get(0));
    $.ajax({
      type: 'POST',
      url: '/chats.json',
      data: fd,
      dataType: 'json',
      processData: false,
      contentType: false
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
  $('#new_group').keyup(function() {
    var name = $('#chat_user_name').val();
    $.ajax({
      type:'GET',
      url: '/groups/search.json',
      data: {
        user: {
          name: name
        }
      },
      dataType: 'json'
    })
    .done(function(data) {

      var users = data.users
      $("div").remove("#user-search-result");
      $.each( users, function() {
        var html = build_user_HTML(this);
        $('#chat-user-result').append(html);
      });
    })
    .fail(function(){
      alert("error")
    })
  });

  $.PeriodicalUpdater(`./json`,{
    //  オプション設定
    method: 'get',      // 送信リクエストURL
    minTimeout: 100,  // 送信インターバル(ミリ秒)
    url : window.location,
    type: 'json',       // xml、json、scriptもしくはhtml (jquery.getやjquery.postのdataType)
    multiplier:1,       // リクエスト間隔の変更
    maxCalls: 0         //　リクエスト回数（0：制限なし）
  }, function (data){
    // dataは上記URLから引き渡され、変更があったか自動で判別される。
    // dataに変更があった場合のみ実行
    var messages = data.messages;
    var new_message = messages[messages.length - 1];
    var users = data.users;
    var new_user = users[users.length - 1];
    if(data.current_user.id != new_user.id){
      html = build_auto_HTML(new_message, new_user);
      $('.chat__main--body--list').append(html);
    };
  });
});

function buildHTML(message) {
  var html = $(`<li><div class="chat__main--body--block"><div class="chat__main--body--block--name">${message.user_name}</div><div class="chat__main--body--block--date">${message.created_at}</div></div><p class="chat__main--body--message">${message.body}</p><img src="${message.image}"></li>`);
  return html;
};

function build_auto_HTML(message,user) {
  var html = $(`<li><div class="chat__main--body--block"><div class="chat__main--body--block--name">${user.name}</div><div class="chat__main--body--block--date">${message.created_at}</div></div><p class="chat__main--body--message">${message.body}</p><img src="${message.image}"></li>`);
  return html;
};

function build_user_HTML(user) {
  var html = $(`<div id="user-search-result"><div class="chat-group-user clearfix"><p class="chat-group-user__name">${user.name}</p><a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a></div></div>`)
  return html;
};

function build_decided_user(user_id, user_name) {
  $('#chat-user-result').empty();
  $('#chat_user_name').val('');
  var html = $(`<div class="chat-group-user clearfix" data-user-id="${user_id}" id="${user_id}"><input type="hidden" name="chat_group[user_ids][]" value="${user_id}"><p class="chat-group-user__name">${user_name}</p><a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove" data-user-id="${user_id}">削除</a></div>`)
  return html;
}
