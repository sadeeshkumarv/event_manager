class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end

    
    User.create!([
      { name: "user1", phone: "test_1", email: "sadathiru@gmail.com" },
      { name: "user2", phone: "test_1", email: "sadathiru1@gmail.com" },
      { name: "user3", phone: "test_1", email: "sadathiru2@gmail.com" },
      { name: "user4", phone: "test_1", email: "sadathiru3@gmail.com" },
      { name: "user5", phone: "test_1", email: "sadathiru4@gmail.com" },
      { name: "user6", phone: "test_1", email: "sadathiru5@gmail.com" },
      { name: "user7", phone: "test_1", email: "sadathiru6@gmail.com" },
      { name: "user8", phone: "test_1", email: "sadathiru7@gmail.com" },
      { name: "user9", phone: "test_1", email: "sadathiru8@gmail.com" },
      { name: "user10", phone: "test_1", email: "sadathiru9@gmail.com" }
    ])
  end
end
