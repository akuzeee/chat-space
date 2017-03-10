$(document).on('turbolinks:load', function() {
  var searchedList = $('#user-search-result');
  var selectedList = $('#chat-group-users');
  var preInput;
  var preFunc;

  function appendSearchedList(user) {
    var item = $('<div class="chat-group-user chat-group-user--searched clearfix" data-user-id=' + user.id + ' data-user-name=' + user.name + '>').append('<p class="chat-group-user__name">' + user.name, '<a class="chat-group-user__btn chat-group-user__btn--add">追加');
    searchedList.append(item);
  }

  function appendSelectedList(user) {
    var item = $('<div class="chat-group-user chat-group-user--selected clearfix" data-user-id=' + user.id + '>').append('<input name="chat_group[user_ids][]", type="hidden", value=' +user.id + ' >', '<p class="chat-group-user__name">' + user.name, '<a class="chat-group-user__btn chat-group-user__btn--remove">削除');
    selectedList.append(item);
  }

  ajaxPost = function(input) {
    var selectedUserIds = $('.chat-group-user--selected').map(function(i, elm) {
      return Number(elm.dataset.userId);
    });
    $('.chat-group-user--searched').remove();
    $.ajax({
    type: 'GET',
    url: '/users/search',
    data: ('keyword=' + input),
    dataType: 'json'
    })
    .done(function(data) {
      if (input.length !== 0) {
        $.each(data.users, function(i, user) {
          if ($.inArray(user.id, selectedUserIds) === -1) {
          appendSearchedList(user);
         }
        });
      }
    });
  };

  // インクリメンタルサーチ
  $('#user-search-field').on('keyup', function() {
    // 半角スペースを無視して検索
    var input = $('#user-search-field').val().replace(/ /g, '');
    if (input != preInput) {
      clearTimeout(preFunc);
      // 引数に無名関数を渡してエラー回避
      preFunc = setTimeout(function() { ajaxPost(input) }, 500);
    }
    preInput = input;
  });

  // 追加ボタンでsearchedUserをselectedUserに移動
  $(document).on('click', '.chat-group-user__btn--add', function() {
    var userBlock = $(this).parent();
    var selectedUser = {
      name: userBlock.data('userName'),
      id: userBlock.data('userId')
    };
    userBlock.remove();
    appendSelectedList(selectedUser);
  });

  // 削除ボタンでselectedUserを削除
  $(document).on('click', '.chat-group-user__btn--remove', function() {
    $(this).parent().remove();
  });
});
