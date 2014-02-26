module Refinery
  module Members
    class Member < Refinery::Core::BaseModel
      extend FriendlyId
        friendly_id :name, :use => [:slugged]

      self.table_name = 'refinery_members'

      attr_accessible :name, :current_position, :biography, :previous_position, :notes, :photo_id, :position

      validates :name, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'
    end
  end
end
