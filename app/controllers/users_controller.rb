class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @columns = ['id', 'user_name', 'email', 'first_name', 'last_name', 'role_names']
    @users= User.paginate(
      :page     => params[:page],
      :per_page => params[:rows],
      :order    => order_by_from_params(params),
      :conditions => filter_option(params)
     )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: json_for_jqgrid(@users, @columns) }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @roles = @user.roles
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @roles = Role.all
    @user = User.new

    respond_to do |format|
      format.js # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @roles = Role.all
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @roles = Role.all
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        update_role_names
        format.html { render action: "index" }
        format.js 
        format.json { render json: @user, status: :created, location: @user }
      else
        format.js { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    params[:user][:role_ids] ||= []
    @roles = Role.all
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        update_role_names
        format.js 
        format.json { head :no_content }
      else
        format.js { render "edit", id: @user.id }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def grid_update
    @user = User.find_by_id(params[:id])
    if params[:oper] == "del"
        @user.destroy
    end

    render :json => @user
  end

private

  def update_role_names
    @user.update_attributes(:role_names => @user.roles.map(&:name).sort.join(","))
  end
  
  # TODO: put this in helper
  def filter_option options
    condition = []
    if options[:_search] == "true"
      str = options[:searchString]
      case options[:searchOper]
        when "cn"
          condition = ["#{options[:searchField]} like ?", "%#{str}%"]
        when "eq"
          condition = ["#{options[:searchField]} = ?", "#{str}"]
      end
    end
    condition
  end

end
