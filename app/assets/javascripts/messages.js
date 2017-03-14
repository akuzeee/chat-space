$(document).on('turbolinks:load', function() {
  var path     = location.pathname;
  var messages = $('.chat-messages');

  function buildHTML(message) {
    var html = $('<li class="chat-message" data-message-id=' + message.id + '>').append('<p class="chat-message__user-name">' + message.user.name + '</p>', '<span class="chat-message__date">' + message.created_at + '</span>', '<div class="chat-message__body">' + message.text + '</div>');
    if (message.image.url) {
      html.append('<img src=' + message.image.url + '>');
    }
    return html;
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var formData = new FormData($('#new_message').get(0));
    $.ajax({
      type:        'POST',
      url:         path,
      contentType: false,
      processData: false,
      data:        formData,
      dataType:    'json'
    })
    .done(function(data) {
      var html = buildHTML(data);
      messages.append(html);
      textField.val('');
    })
    .fail(function() {
      alert('メッセージを入力してください');
    })
    .always(function() {
      $('.send-btn').removeAttr('disabled');
    });
  });

  if (path.match('/messages')) {
    var timer = setInterval(function(){
      $.ajax({
        type:     'GET',
        url:       path,
        dataType: 'json'
      })
      .done(function(data) {
        var existedMessageIds = messages.children().map(function(i, elm) {
          return Number(elm.dataset.messageId);
        });
        $.each(data, function(i, message) {
          if ($.inArray(message.id, existedMessageIds) === -1) {
            var html = buildHTML(message);
            messages.append(html);
         }
        });
      });
    }, 5000);
  }
  // turbolinks によってページ遷移先にsetIntervalが引き継がれてしまうバグを解除
  $(this).on('turbolinks:click', function() {
    clearInterval(timer);
  });
});
