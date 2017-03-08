$(function() {
  function buildHTML(message) {
    var html = $('<li class="chat-message">').append('<p class="chat-message__user-name">' + message.user.name + '</p>', '<span class="chat-message__date">' + message.created_at + '</span>', '<div class="chat-message__body">' + message.text + '</div>');
    return html;
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var text = textField.val();
    var path = location.pathname;
    $.ajax({
      type: 'POST',
      url: path,
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
    })
    .fail(function() {
      alert('error');
    })
    .always(function() {
      $('.send-btn').removeAttr('disabled');
    });
  });
});
