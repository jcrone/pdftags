class PagesController < ApplicationController


def testing
  respond_to do |format|
    format.html
    format.pdf do
      pdf = Prawn::Document.new
      pdf.text "Hello World"
      send_data pdf.render
    end
  end
end


end
