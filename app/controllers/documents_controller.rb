class DocumentsController < ApplicationController
  
  
  def download 
    document = Document.find(params[:id])
    @doc = document.doc
    @title = document.title.to_s
    file =  (@title+".textile")
    File.open(file, "w+"){ |f| f << @doc }
    send_file(file, :type => "text/textile; charset=utf-8")
  end
  
  
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      flash[:notice] = "Successfully created document."
      render :action => "edit"
    else
      render :action => 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params[:document])
      flash[:notice] = "Successfully updated document."
      render :action => "edit"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    flash[:notice] = "Successfully destroyed document."
    redirect_to documents_url
  end
end
