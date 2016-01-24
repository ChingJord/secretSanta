class MembersController < ApplicationController
		before_action :find_member, only: [:show, :edit, :update, :destroy]

	  def index
		  	@members = Member.all
		  	@participants = []
		  	@members.each do |member|
		  			@participants.push(member.first_name + ' ' + member.last_name)
		  	end
		  	@already_assigned = []
		  	@assignees = []
				@participants.each do |participant|
						@leftovers = @participants - @already_assigned - [participant]
						@assign = @leftovers.sample
						@already_assigned.push(@assign)
					  @assignees.push([participant, @assign])
				end

	  end

	  def new
				@member = Member.new
		end

		def create
				@member = Member.new(member_params)
				if @member.save
						redirect_to @member, notice: "Successfully created new member"
				else
						render "new"
				end
		end

	  def edit
	  end

	  def update
				if @member.update(member_params)
						redirect_to @member
				else
						render "edit"
				end
		end

		def destroy
				@member.destroy
				redirect_to root_path, notice: "Successfully deleted member"
		end

	  def show
	  end

private

		def find_member
				@member = Member.find(params[:id])
		end

		def member_params
				params.require(:member).permit(:first_name, :last_name, :partner, :last_assigned)
		end

end

