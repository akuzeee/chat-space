$(document).on('turbolinks:load', function() {
  var selectedList = $('#chat-group-users');

  function appendSelectedList(user) {
    var item = $('<div class="chat-group-user chat-group-user--selected clearfix" data-user-id=' + user.id + '>').append('<input name="chat_group[user_ids][]", type="hidden", value=' +user.id + ' >', '<p class="chat-group-user__name">' + user.name, '<a class="chat-group-user__btn chat-group-user__btn--remove">削除');
    selectedList.append(item);
  }

  // 追加ボタンでsearchedUserをselectedUserに移動
  $(document).on('click', '.chat-group-user__btn--add', function() {
    var userBlock = $(this).parent();
    var selectedUser = {
      name: userBlock.find('p').text(),
      id: userBlock[0].dataset.userId
    };
    userBlock.remove();
    appendSelectedList(selectedUser);
  });

  // 削除ボタンでselectedUserを削除
  $(document).on('click', '.chat-group-user__btn--remove', function() {
    $(this).parent().remove();
  });
});
