module UsersHelper

  include JqgridsHelper

  def users_jqgrid

    options = {:on_document_ready => true, :html_tags => false}

    grid = [{
      :url => '/users',
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['User ID','User Name', 'Email','First Name','Last Name','Roles'],
      :colModel  => [
        { :name => 'id',        :index => 'id',         :width => 80, :align => 'center', :search => false},
        { :name => 'user_name', :index => 'user_name',  :width => 90,  :align => 'center', :editable => true, :search => true },
        { :name => 'email',     :index => 'email',      :width => 180, :editable => true, :search => true},
        { :name => 'first_name',:index => 'first_name', :width => 120, :editable => true, :search => true },
        { :name => 'last_name', :index => 'last_name',  :width => 120, :editable => true, :search => true },
        { :name => 'roles',     :index => 'role_names', :width => 150,:search => true, :sortable => false }
      ],
      :editurl => '/users/grid_update',
      :pager => '#users_pager',
      :rowNum => 20,
      :rowList => [20, 40, 60],
      :sortname => 'id',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'User Admin',
      :height => 400,
      :rowTotal => -1
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)

    pager = [:navGrid, "#users_pager", {:edit => false, :add => false, :search => true, :del => true, :refresh => true},
            {height:280, :closeAfterEdit => true, :closeOnEscape => true, :search => true, :refresh => true},
            {height:280, :closeAfterEdit => true, :closeOnEscape => true, :search => true, :refresh => true},
            {reloadAfterSubmit:false},
            {}]

    jqgrid_api 'users_list', grid, pager, options

  end

end
