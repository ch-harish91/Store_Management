class SetDefaultRoleForUsers < ActiveRecord::Migration[7.1]
  def change
    User.where(role: nil).update_all(role: 'normal_user')
  end
end
