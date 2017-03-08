$(function() {
  function buildHTML(message) {
    var html = $('<li class="chat-message">').append(message.text);
    return html;
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var text = textField.val();
    $.ajax({
      type: 'POST',
      url: '/chat_groups/62/messages',
      data: {
        message: {
          text: text
        }
      },
      dataType: 'json'
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.chat-messages').append(html);
      textField.val('');
      console.log('success')
    })
    .fail(function() {
      alert('error');
    });
  });
});
