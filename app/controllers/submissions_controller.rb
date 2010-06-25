require 'rexml/document'

class SubmissionsController < ApplicationController
  
  before_filter :restrict_to_owner_or_admin, :only => [:show]
  
  # GET /submissions
  # GET /submissions.xml
  def index
    
    if current_user.admin?
      @submissions = Submission.find(:all, :order => 'created_at DESC')
    else
      @submissions = Submission.find(:all, :conditions => {:user_id => session[:user_id]}, :order => 'created_at DESC')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.xml
  def show
    @submission = Submission.find(params[:id])
    
    #now lets get the nice xml to display!
    xml = Ruote::Parser.to_xml(@submission.process_definition)
    doc = REXML::Document.new xml
    @nice_xml = ''
    doc.write(@nice_xml,2)
    @task_outputs = ''
    @submission.tasks.each do|t|
      @task_outputs += "\n== #{t.rank} - #{t.name} =====================\n\n"
      @task_outputs += "#{t.exec_output}\n"
    end
    
    
    # get the prety input files
    
    @pretty_input_files_list = Array.new
    
    @submission.input_files.each do |inf|
      i = Item.find(inf)
      
      @pretty_input_files_list << "#{i.attachment_file_name}"
      
    end
        
    flash[:error] = "Your submission appears to have an error and is probably stuck. Please contact your system administrator." if (! @submission.last_error.blank? && @submission.active?)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.xml
  def new
    @submission = Submission.new
    @workflow = Workflow.find(params[:id])
    @items_list = current_user.build_items_list

    c = 0
    @workflow.protocols.each do |p|
      @submission.tasks.build(:protocol => p, :rank => c)
      c += 1
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # POST /submissions
  # POST /submissions.xml
  def create
    @submission = Submission.new(params[:submission])
    @items_list = current_user.build_items_list
    
    respond_to do |format|
      if @submission.save
        @submission.submit_job
        flash[:notice] = 'Submission was successfully created.'
        format.html { redirect_to(@submission) }
        format.xml  { render :xml => @submission, :status => :created, :location => @submission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_options
    
    @options = Item.get(:index_all, :project_id => params[:project_id])
    
    
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.xml
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to(submissions_url) }
      format.xml  { head :ok }
    end
  end
  
  def restrict_to_owner_or_admin
    
    @submission = Submission.find(params[:id])
    unless current_user.admin? || current_user.id == @submission.user_id
      flash[:error] = "You do not have access to this submission. Please log in again."
      store_target_location
      redirect_to login_url
      return
    
    end
    
  end
  
  
  
end
