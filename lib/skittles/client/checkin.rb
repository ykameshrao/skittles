module Skittles
  class Client
    # Define methods related to checkins.
    # @see http://developer.foursquare.com/docs/checkins/checkins.html
    module Checkin
      # Allows a user to checkin to a place.
      #
      # @param broadcast [String] How much to broadcast this check-in, ranging from private (off-the-grid) to public,faceboook,twitter.
      # @param options [Hash] A customizable set of options.
      # @option options [String] venueId The venue where the user is checking in.
      # @option options [String] venue Name of the venue.
      # @option options [String] shout A message about a check-in. (140 character max.)
      # @option options [String] ll Latitude and longitude of the user's location.
      # @option options [Decimal] llAcc Accuracy of the user's latitude and longitude, in meters.
      # @option options [Decimal] alt Altitude of the user's location, in meters.
      # @option options [Decimal] altAcc Vertical accuracy of the user's location, in meters.
      # @return [Hashie::Mash] A checkin object.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/checkins/add.html
      def add_checkin(broadcast = 'private', options = {})
        post("checkins/add", { :broadcast => broadcast }.merge(options)).checkin
      end
      
      # Get details of a checkin.
      #
      # @param id [String] The ID of the checkin to retrieve additional information for.
      # @param options [Hash] A customizable set of options.
      # @option options [String] signature When checkins are sent to public feeds such as Twitter, foursquare appends a signature (s=XXXXXX) allowing users to bypass the friends-only access check on checkins. The same value can be used here for programmatic access to otherwise inaccessible checkins.
      # @return [Hashie::Mash] A complete checkin object.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/checkins/checkins.html
      def checkin(id, options = {})
        get("checkins/#{id}", options).checkin
      end
      
      # Comment on a check-in.
      #
      # @param id [String] The id of the checkin to add a comment to.
      # @param text [String] The text of the comment, up to 200 characters.
      # @return [Hashie::Mash] The newly-created comment.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/checkins/addcomment.html
      def checkin_addcomment(id, text)
        post("checkins/#{id}/addcomment", { :text => text }).comment
      end
      
      # Remove a comment from a checkin, if the acting user is the author or
      # the owner of the checkin.
      #
      # @param checkin_id [String] The id of the checkin to remove a comment from.
      # @param comment_id [String] The id of the comment to remove.
      # @return [Hashie::Mash] The checkin, minus this comment.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/checkins/deletecomment.html
      def checkin_deletecomment(checkin_id, comment_id)
        post("checkins/#{checkin_id}/deletecomment", { :commentId => comment_id }).checkin
      end
      
      # Returns a list of recent checkins from friends.
      #
      # @param ll [String] Latitude and longitude of the user's location, so response can include distance.
      # @param options [Hash] A customizable set of options.
      # @option options [Integer] Number of results to return, up to 100.
      # @option options [Integer] Seconds after which to look for checkins.
      # @return [Hashie::Mash] An array of checkin objects with user details present.
      # @requires_acting_user Yes
      # @see http://developer.foursquare.com/docs/checkins/recent.html
      def recent_checkins(ll, options = {})
        get("checkins/recent", { :ll => ll }.merge(options)).recent
      end
    end
  end
end