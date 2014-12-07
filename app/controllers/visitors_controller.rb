class VisitorsController < ApplicationController
  def index
    session_stuff

    @uploads = Dir.entries(Rails.root.join('uploads')).reject { |e| ['..', '.', '.keep'].include? e }.map do |e|
      [e, "/uploads/#{e}"]
    end
  end
  def create
    uploaded = params[:file]
    File.open(Rails.root.join('uploads', uploaded.original_filename), 'wb') do |file|
      file.write(uploaded.read)
    end

    redirect_to root_path
  end

  def show
    filename = "#{params[:file]}.#{params[:format]}"
    send_file(Rails.root.join('uploads', filename))
  end

  private
  def session_stuff
    session[:mysecret] = 'super sneaky encrypted sekret'
  end
end
