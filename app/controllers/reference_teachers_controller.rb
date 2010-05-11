class ReferenceTeachersController < ApplicationController
  # GET /reference_teachers
  # GET /reference_teachers.xml
  def index
    @reference_teachers = ReferenceTeacher.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reference_teachers }
    end
  end

  # GET /reference_teachers/1
  # GET /reference_teachers/1.xml
  def show
    @reference_teacher = ReferenceTeacher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reference_teacher }
    end
  end

  # GET /reference_teachers/new
  # GET /reference_teachers/new.xml
  def new
    @reference_teacher = ReferenceTeacher.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reference_teacher }
    end
  end

  # GET /reference_teachers/1/edit
  def edit
    @reference_teacher = ReferenceTeacher.find(params[:id])
  end

  # POST /reference_teachers
  # POST /reference_teachers.xml
  def create
    @reference_teacher = ReferenceTeacher.new(params[:reference_teacher])

    respond_to do |format|
      if @reference_teacher.save
        flash[:notice] = 'ReferenceTeacher was successfully created.'
        format.html { redirect_to(@reference_teacher) }
        format.xml  { render :xml => @reference_teacher, :status => :created, :location => @reference_teacher }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reference_teacher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reference_teachers/1
  # PUT /reference_teachers/1.xml
  def update
    @reference_teacher = ReferenceTeacher.find(params[:id])

    respond_to do |format|
      if @reference_teacher.update_attributes(params[:reference_teacher])
        flash[:notice] = 'ReferenceTeacher was successfully updated.'
        format.html { redirect_to(@reference_teacher) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reference_teacher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reference_teachers/1
  # DELETE /reference_teachers/1.xml
  def destroy
    @reference_teacher = ReferenceTeacher.find(params[:id])
    @reference_teacher.destroy

    respond_to do |format|
      format.html { redirect_to(reference_teachers_url) }
      format.xml  { head :ok }
    end
  end
end
