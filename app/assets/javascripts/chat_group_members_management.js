$(function() {
  var selectedList = $('#chat-group-users')
  function appendSelectedList(user) {
    var item = $('<div class="chat-group-user clearfix" data-user-id=' + user.id + '>').append('<input name="chat_group[user_ids][]", type="hidden", value=' +user.id + ' >', '<p class="chat-group-user__name">' + user.name, '<a class="chat-group-user__btn chat-group-user__btn--remove">削除');
    selectedList.append(item);
  }

  $(document).on('click', '.chat-group-user__btn--add', function() {
    var userBlock = $(this).parent();
    var selectedUser = {
      name: userBlock.find('p').text(),
      // searchedUserが動的な要素のためかdatasetにアクセスできないのでattrを使う
      id: userBlock.attr('data-user-id')
    };
    userBlock.remove();
    appendSelectedList(selectedUser);
  });
});
