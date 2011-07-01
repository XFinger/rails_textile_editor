class DocumentsController < ApplicationController
  
   def download 
    document = Document.find(params[:id])
    @doc = document.doc
    @title = document.title.to_s
    file_name =  (@title+".textile")
    send_data(@doc, :filename => file_name, :type => "text/textile")
   end
  
  def download_html
    document = Document.find(params[:id])
    @doc = RedCloth.new(document.doc).to_html
    @title = document.title.to_s
    file_name =  (@title+".html")
    send_data(@doc, :filename => file_name, :type => "text/html")
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
