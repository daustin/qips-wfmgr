class WorkflowsController < ApplicationController

  before_filter :restrict_to_owner_or_admin, :only => [:show, :edit, :update]

  # GET /workflows
  # GET /workflows.xml
  def index
    
    if current_user.admin?
      @workflows = Workflow.find(:all)
    else
      @workflows = Workflow.find(:all, :conditions => "user_id IS NULL OR user_id = '#{session[:user_id]}'")
    end
    @my_workflows = current_user.workflows

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workflows }
    end
  end
 
  # GET /workflows/1
  # GET /workflows/1.xml
  def show
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workflow }
    end
  end

  # GET /workflows/new
  # GET /workflows/new.xml
  def new
    @workflow = Workflow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workflow }
    end
  end

  # GET /workflows/1/edit
  def edit
    @workflow = Workflow.find(params[:id])
  end

  # POST /workflows
  # POST /workflows.xml
  def create
    @workflow = Workflow.new(params[:workflow])
    @workflow.user_id = nil if params[:make_public]
    respond_to do |format|
      if @workflow.save
        flash[:notice] = 'Workflow was successfully created.'
        format.html { 
          
          if params[:submit_flag].to_i == 1
             redirect_to(new_workflow_submission_url(:id => @workflow.id))
          else
            redirect_to(workflows_path)
          end
                   
          }
        format.xml  { render :xml => @workflow, :status => :created, :location => @workflow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workflow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workflows/1
  # PUT /workflows/1.xml
  def update
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      if @workflow.update_attributes(params[:workflow])
        flash[:notice] = 'Workflow was successfully updated.'
        format.html { redirect_to(@workflow) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workflow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workflows/1
  # DELETE /workflows/1.xml
  def destroy
    @workflow = Workflow.find(params[:id])
    @workflow.destroy

    respond_to do |format|
      format.html { redirect_to(workflows_url) }
      format.xml  { head :ok }
    end
  end
  
  def restrict_to_owner_or_admin
    
    @workflow = Workflow.find(params[:id])
    unless current_user.admin? || current_user.id == @workflow.user_id
      flash[:error] = "You do not have access to this workflow. Please log in again."
      store_target_location
      redirect_to login_url
      return
    
    end
    
  end
  
  
  
end
