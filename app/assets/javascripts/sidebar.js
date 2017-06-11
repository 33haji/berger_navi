// サイドバーの検索リストをプルダウン表示する
$(document).on('turbolinks:load', function(){
  $("#sidebar-area-content").hide();
  $("#sidebar-area").hover(function(){
      $("#sidebar-area-content:not(:animated)").slideDown();
    },function(){
      $("#sidebar-area-content").slideUp();
    });
});
$(document).on('turbolinks:load', function(){
  $("#sidebar-genre-content").hide();
  $("#sidebar-genre").hover(function(){
      $("#sidebar-genre-content:not(:animated)").slideDown();
    },function(){
      $("#sidebar-genre-content").slideUp();
    });
});
