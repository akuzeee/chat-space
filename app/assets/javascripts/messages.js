$(function() {
  function buildHTML(message) {
    var html = $('<li class="chat-message">').append('<p class="chat-message__user-name">' + message.user.name + '</p>', '<span class="chat-message__date">' + message.created_at + '</span>', '<div class="chat-message__body">' + message.text + '</div>');
    if (message.image.url) {
      html.append('<img src=' + message.image.url + '>');
    }
    return html;
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var params = new FormData($('#new_message').get(0));
    var path = location.pathname;
    $.ajax({
      type:        'POST',
      url:         path,
      contentType: false,
      processData: false,
      data:        params,
      dataType:    'json'
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
