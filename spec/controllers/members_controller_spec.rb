require 'rails_helper'
require 'spec_helper'

RSpec.describe MembersController, type: :controller do

	it "has a valid factory" do
    FactoryGirl.create(:member).should be_valid
  end

	describe "GET #index" do

	  it "populates an array of members" do
	    member = FactoryGirl.create(:member)
	    get :index
	    assigns(:members).should == [member]
	  end

	  it "renders the :index view" do
	    get :index
	    response.should render_template :index
	  end

	end

	describe "GET #show" do

	  it "assigns the requested member to @member" do
	    member = FactoryGirl.create(:member)
	    get :show, id: member
	    assigns(:member).should eq(member)
	  end

	  it "renders the #show view" do
	    get :show, id: FactoryGirl.create(:member)
	    response.should render_template :show
	  end

	end

  describe "POST create" do

	    it "creates a new member" do
	      expect{
	        post :create, member: FactoryGirl.attributes_for(:member)
	      }.to change(Member,:count).by(1)
	    end

	    it "redirects to the new member" do
	      post :create, member: FactoryGirl.attributes_for(:member)
	      response.should redirect_to Member.last
	    end

	end

	describe 'PUT update' do

	  before :each do
	    @member = FactoryGirl.create(:member)
	  end

    it "located the requested @member" do
      put :update, id: @member, member: FactoryGirl.attributes_for(:member)
      assigns(:member).should eq(@member)
    end

    it "changes @member's attributes" do
      put :update, id: @member, member: FactoryGirl.attributes_for(:member, name: "Larry", partner: "Smith", last_assigned: "John Key")
      @member.reload
      @member.name.should eq("Larry")
      @member.partner.should eq("Smith")
      @member.last_assigned.should eq("John Key")
    end

    it "redirects to the updated member" do
      put :update, id: @member, member: FactoryGirl.attributes_for(:member)
      response.should redirect_to @member
    end

	end

	describe 'DELETE destroy' do

	  before :each do
	    @member = FactoryGirl.create(:member)
	  end

	  it "deletes the member" do
	    expect{delete :destroy, id: @member}.to change(Member,:count).by(-1)
	  end

	  it "redirects to home page" do
	    delete :destroy, id: @member
	    response.should redirect_to root_path
	  end
	end

end
