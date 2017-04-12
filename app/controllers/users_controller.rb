class UsersController < Clearance::UsersController

	def show
	  @users = User.all
	 end

	def edit
	  	@user = User.find(params[:id])
	end

	def update
  		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success] = "update success!!"
			render :show
		else
			flash[:danger] = "update fail!!"
			render 	:edit
		end	
  end

	def delete
	 	@user = User.find_by(params[:id])
	  	@user.destroy
	  	redirect_to '/'
	end	

	private

	  def user_params
	    params.require(:user).permit(:email, :password, :gender, :country)
	  end
end
