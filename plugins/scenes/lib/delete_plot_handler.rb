module AresMUSH
  module Scenes
    class DeletePlotRequestHandler
      def handle(request)
        plot = Plot[request.args[:id]]
        enactor = request.enactor
        
        if (!plot)
          return { error: "Plot not found." }
        end
        
        if (!enactor.is_admin?)
          return { error: "You are not allowed to delete that scene." }
        end
        
        plot.delete
        {
        }
      end
    end
  end
end