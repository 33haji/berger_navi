// サイドバーの検索リストをプルダウン表示する
$(document).on('turbolinks:load', function(){
  $("#sidebar-content").hide();
  $("#sidebar").hover(function(){
      $("#sidebar-content:not(:animated)").slideDown();
    },function(){
      $("#sidebar-content").slideUp();
    });
});
