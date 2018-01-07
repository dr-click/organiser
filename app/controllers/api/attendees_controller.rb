module Api
  class AttendeesController < ApiApplicationController
    authorize_resource

    api :GET, '/attendees/:id/revoke', "Revoke attendee access code"
    description "Revoke a given attendee access code, It requires organiser user"
    param :secret, String, :desc => "Generated secret for the url /attendees/:id/revoke with Organiser user token", :required => true
    param :token, String, :desc => "Organiser user token", :required => true
    example 'Response_success: {"success":true,"attendee":{}}'
    def revoke
      attendee = Attendee.find(params[:id])
      attendee.update_column(:access_code, nil)
      render :json => { success: true, attendee: attendee.as_json}, :status => 200
    end

    #######
    private
    #######

  end
end
