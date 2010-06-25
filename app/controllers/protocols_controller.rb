class ProtocolsController < ApplicationController
  # GET /protocols
  # GET /protocols.xml

  before_filter :restrict_to_admin

  def index
    @protocols = Protocol.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @protocols }
    end
  end

  # GET /protocols/1
  # GET /protocols/1.xml
  def show
    @protocol = Protocol.find(params[:id])
    @pretty_selected_items_list = @protocol.build_selected_items_list.collect{|li| li[0]}
    flash[:error] = "The role for this protocol is no longer available.  Please select a new role." if @protocol.role.nil? || @protocol.role.empty?

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @protocol }
    end
  end

  # GET /protocols/new
  # GET /protocols/new.xml
  def new
    @protocol = Protocol.new
    @items_list = current_user.build_items_list

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @protocol }
    end
  end

  # GET /protocols/1/edit
  def edit
    @protocol = Protocol.find(params[:id])
    @items_list = current_user.build_items_list

  end

  # POST /protocols
  # POST /protocols.xml
  def create
    @protocol = Protocol.new(params[:protocol])
    @items_list = current_user.build_items_list
    respond_to do |format|
      if @protocol.save
        flash[:notice] = 'Protocol was successfully created.'
        format.html { redirect_to(@protocol) }
        format.xml  { render :xml => @protocol, :status => :created, :location => @protocol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @protocol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /protocols/1
  # PUT /protocols/1.xml
  def update
    @protocol = Protocol.find(params[:id])
    @protocol.default_aux_files = [] if params[:default_aux_files].nil?

    respond_to do |format|
      if @protocol.update_attributes(params[:protocol])
        flash[:notice] = 'Protocol was successfully updated.'
        format.html { redirect_to(@protocol) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @protocol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /protocols/1
  # DELETE /protocols/1.xml
  def destroy
    @protocol = Protocol.find(params[:id])
    @protocol.destroy

    respond_to do |format|
      format.html { redirect_to(protocols_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def update_options
    
    @options = Item.get(:index_all, :project_id => params[:project_id])
    
    
  end
  
    
  
end
