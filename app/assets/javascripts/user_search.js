$(function() {
  var searchResult = $('#user-search-result');
  var preInput;

  function appendSearchedList(user) {
    var item = $('<div class="chat-group-user searched-user clearfix">').append('<p class="chat-group-user__name">' + user.name);
    searchResult.append(item);
  }

  function splitWord(word) {
    var words = word.split(' ').filter(function(e) { return e; });
    return words;
  }

  function convertToReg(words) {
    var reg = RegExp(words.join('|'));
    return reg;
  }

  $('#user-search-field').on('keyup', function() {
    var selectedUserName = $('.chat-group-user__name--selected').text().replace(/\r?\n/g,"");
    var selectedUserNames = splitWord(selectedUserName);
    var regSelectedUserNames = convertToReg(selectedUserNames);
    // 半角スペースを無視して検索
    var input = $('#user-search-field').val().replace(/ /g, '');
    if (input != preInput) {
      $('.searched-user').remove();
      $.ajax({
      type: 'GET',
      url: 'search',
      data: ('q=' + input),
      dataType: 'json'
      })
      .done(function(data) {
        if (input.length !== 0) {
          $.each(data.searched_users, function(i, user) {
            if (!user.name.match(regSelectedUserNames)) {
             appendSearchedList(user);
           }
          });
        }
      })
    }
    preInput = input;
  });
});
