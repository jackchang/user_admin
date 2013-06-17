<h1>Listing users</h1>

<table id=users_list></table>
<div id=users_pager></div>

<script>
  function myFormatter ( cellvalue, options, rowObject ) {
    return 
  }
</script>

<% content_for :head do %>
  <%= raw(users_jqgrid) %>
<% end %>

<br />

