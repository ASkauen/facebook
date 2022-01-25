class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  
  after_create_commit do
    broadcast_update_to "notifications",
                        partial: "users/notifs_box",
                        target: "notifs-box#{recipient.id}",
                        locals: {recipient: recipient}
    
    broadcast_update_to "bell",
                        partial: "users/buttons/bell",
                        target: "bell#{recipient.id}",
                        locals: {enable: true}
  end
  after_destroy_commit do
    broadcast_update_to "notifications",
                        partial: "users/notifs_box",
                        target: "notifs-box#{recipient.id}",
                        locals: {recipient: recipient}

    broadcast_update_to "bell",
                        partial: "users/buttons/bell",
                        target: "bell#{recipient.id}",
                        locals: {enable: recipient.notifications.any?}
  end
end
