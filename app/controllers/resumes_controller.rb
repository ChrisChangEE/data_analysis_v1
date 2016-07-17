class ResumesController < ApplicationController
   def index
    @resumes = Resume.all
  end

  def new
    @resume = Resume.new
  end

  def create

    @resume = Resume.new(resume_params)
      
    if @resume.save
      redirect_to resumes_path, notice: "The resume #{@resume.name} has been uploaded."
    else
      render "new"  
    end

    # name = params[:attachment]
    # directory = "public/data"

    # # create the file path
    # path = File.join(directory)

    # file = params[:attachment]
    # do something to the file, for example:
    #    file.read(2) #=> "ab"

  end

  # def download
  #   path = "/#{resume.resume}"
  #   send_file path, :x_sendfile=>true
  # end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
  end

private
  def resume_params
    params.require(:resume).permit(:name, :attachment)
  end
end
