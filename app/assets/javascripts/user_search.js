$(function() {
  var searchResult = $('#user-search-result');
  var preInput;
  var preFunc;

  function appendSearchedList(user) {
    var item = $('<div class="chat-group-user searched-user clearfix">').append('<p class="chat-group-user__name">' + user.name);
    searchResult.append(item);
  }

  ajaxPost = function(input) {
    var selectedUserIds = $('.chat-group-user').map(function(i, elm) {
      return Number(elm.dataset.userId);
    });
    $('.searched-user').remove();
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
});
