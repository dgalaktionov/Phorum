# A controller for administration actions over users
class AdminsController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  # GET /admins
  # GET /admins.json
  # This probably should be in RegistrationsController...
  def index
    @users = User.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if params[:commit] == "Update"
        if @user.update(admin_params)
          format.html { redirect_to users_path, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin }
        else
          format.html { render :edit }
          format.json { render json: @admin.errors, status: :unprocessable_entity }
        end
      elsif params[:commit] == "Delete account"
        if admin_params[:delete_stuff] == "1"
          for p in @user.posts
           p.destroy
          end
          
          for t in @user.topics
            for p in t.posts
              p.destroy
            end
            
            t.destroy
          end
          
          @user.destroy
        else
          kill_user(@user)
        end
        
        format.html { redirect_to users_path, notice: 'User was successfully deleted.' }
      else
        fail "No method"
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:user).permit(:name, :email, :password, :delete_stuff, :user_type)
    end
end
