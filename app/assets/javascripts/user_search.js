$(function() {
  var searchResult = $('#user-search-result');
  var preWord;

  function appendList(user) {
    var item = $('<div class="chat-group-user searched-user clearfix">').append('<input name= "chat_group[user_ids][]" type= "hidden" value= ' + user.id + '></input>', '<p class="chat-group-user__name">' + user.name + '</p>');
    searchResult.append(item);
  }

  function editElement(element) {
    var result = "^" + element;
    return result;
  }

  $('#user-search-field').on('keyup', function() {
    var selectedUserName = $('.chat-group-user__name--selected').text()
    var selectedUserNames = selectedUserName.replace(/\r?\n/g,"");
    var selectedUserNames = selectedUserNames.split(' ').filter(function(e) { return e; })
    var selectedUserNames = RegExp(selectedUserNames.join('|'))

    var input = $('#user-search-field').val();
    var inputs = input.split(' ').filter(function(e) { return e; });
    var newInputs = inputs.map(editElement);
    var word = newInputs.join('|')
    var reg = RegExp(word);

    if (word != preWord) {
      $('.searched-user').remove();
      if (input.length !== 0) {
        $.each(users_list, function(i, user) {
          if (user.name.match(reg)) {
            appendList(user);
          }
        });
      }
    }
    preWord = word;
  });
});
