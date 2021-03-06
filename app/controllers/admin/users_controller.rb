class Admin::UsersController < Admin::BaseController
  load_and_authorize

  def index
		@table = UserTable.new(self, @users, search: true)
		@table.respond
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admin_users_path, success: "Utilisateur créé"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
    @user.assign_attributes(user_params)
		if @user.save
			redirect_to admin_users_path, success: "Utilisateur mis à jour"
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		redirect_to admin_users_path, success: "Utilisateur supprimé"
	end

  private

  def user_params
    params.require(:user).permit(:gender, :birthday, :firstname, :lastname, :email, :phone, :address, :npa, :city, :country, :newsletter, :password, :password_confirmation)
  end

end
