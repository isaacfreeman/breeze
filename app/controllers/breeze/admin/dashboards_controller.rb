module Breeze
  module Admin
    class DashboardsController < AdminController
      unloadable
      
      def show
        @log_messages = Activity::LogMessage.order_by([[ :created_at, -1 ]]).paginate :page => 1
      end
    end
  end
end