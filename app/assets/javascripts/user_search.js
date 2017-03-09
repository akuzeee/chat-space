$(function() {
  var searchResult = $('#user-search-result');
  var preWord;

  function appendSelectingList(user) {
    var item = $('<div class="chat-group-user searched-user clearfix">').append('<input name= "chat_group[user_ids][]" type= "hidden" value= ' + user.id + '></input>', '<p class="chat-group-user__name">' + user.name + '</p>');
    searchResult.append(item);
  }

  function editElement(element) {
    var result = "^" + element;
    return result;
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

    var input = $('#user-search-field').val();
    var inputs = splitWord(input);
    var newInputs = inputs.map(editElement);
    var reg = convertToReg(newInputs);

    if (reg != preWord) {
      $('.searched-user').remove();
      if (inputs.length !== 0) {
        $.each(users_list, function(i, user) {
          if (user.name.match(reg) && !user.name.match(regSelectedUserNames)) {
            appendSelectingList(user);
          }
        });
      }
    }
    preWord = reg;
  });
});
