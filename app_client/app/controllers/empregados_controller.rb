class EmpregadosController < ApplicationController
  # GET /empregados
  # GET /empregados.xml
  def index
    @empregados = EmpregadoMiddle.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empregados }
    end
  end

  # GET /empregados/1
  # GET /empregados/1.xml
  def show
    @empregado = EmpregadoMiddle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empregado }
    end
  end

  # GET /empregados/new
  # GET /empregados/new.xml
  def new
    @empregado = EmpregadoMiddle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empregado }
    end
  end

  # GET /empregados/1/edit
  def edit
    @empregado = EmpregadoMiddle.find(params[:id])
  end

  # POST /empregados
  # POST /empregados.xml
  def create
    @empregado = EmpregadoMiddle.new(params[:empregado])

    respond_to do |format|
      if @empregado.save
        flash[:notice] = 'EmpregadoMiddle was successfully created.'
        format.html { redirect_to(@empregado) }
        format.xml  { render :xml => @empregado, :status => :created, :location => @empregado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empregado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empregados/1
  # PUT /empregados/1.xml
  def update
    @empregado = EmpregadoMiddle.find(params[:id])

    respond_to do |format|
      if @empregado.update_attributes(params[:empregado])
        flash[:notice] = 'EmpregadoMiddle was successfully updated.'
        format.html { redirect_to(@empregado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empregado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /empregados/1
  # DELETE /empregados/1.xml
  def destroy
    @empregado = EmpregadoMiddle.find(params[:id])
    @empregado.destroy

    respond_to do |format|
      format.html { redirect_to(empregados_url) }
      format.xml  { head :ok }
    end
  end
end
