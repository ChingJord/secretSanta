class MembersController < ApplicationController
		before_action :find_member, only: [:show, :edit, :update, :destroy]

	  def index
		  	@members = Member.all
		  	@participants = @members.clone
		  	@already_assigned = []
		  	@assignees = []
				@participants.each do |participant|
						@leftovers = @participants - @already_assigned - [participant]
						if !@leftovers.empty?

								@assign = choose_match(participant, @leftovers)

								if !(@assign == [])
										@already_assigned.push(@assign)
									  @assignees.push([participant, @assign.name])
									  Member.update(participant.id, :last_assigned => @assign.name)
								else
										@assignees.push([participant, "Sorry no match was made, please refresh the match"])
							  end
						else
								@assignees.push([participant, "Sorry no match was made, please refresh the match"])
					  end
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
				params.require(:member).permit(:name, :partner, :last_assigned)
		end

		def choose_match(participant, matches)
	  	try = matches.sample
	  	if try.name.to_s.downcase == participant.partner.to_s.downcase || try.name.to_s.downcase == participant.last_assigned.to_s.downcase
	  		new_list = matches - [try]
	  		if !new_list.empty?
	  			choose_match(participant, new_list)
	  		else
	  			return []
	  		end
	  	else
	  		return try
	  	end
	  end

end

