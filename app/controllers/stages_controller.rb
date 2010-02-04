class StagesController < ApplicationController
  # GET /stages
  # GET /stages.xml
  def index
    @stages = Stage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stages }
    end
  end

  # GET /stages/1
  # GET /stages/1.xml
  def show
    @stage = Stage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stage }
    end
  end

  # GET /stages/new
  # GET /stages/new.xml
  def new
    @stage = Stage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stage }
    end
  end

  # GET /stages/1/edit
  def edit
    @stage = Stage.find(params[:id])
  end

  # POST /stages
  # POST /stages.xml
  def create
    @stage = Stage.new(params[:stage])

    respond_to do |format|
      if @stage.save
        flash[:notice] = 'Stage was successfully created.'
        format.html { redirect_to(@stage) }
        format.xml  { render :xml => @stage, :status => :created, :location => @stage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stages/1
  # PUT /stages/1.xml
  def update
    @stage = Stage.find(params[:id])

    respond_to do |format|
      if @stage.update_attributes(params[:stage])
        flash[:notice] = 'Stage was successfully updated.'
        format.html { redirect_to(@stage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stages/1
  # DELETE /stages/1.xml
  def destroy
    @stage = Stage.find(params[:id])
    @stage.destroy

    respond_to do |format|
      format.html { redirect_to(stages_url) }
      format.xml  { head :ok }
    end
  end
end
