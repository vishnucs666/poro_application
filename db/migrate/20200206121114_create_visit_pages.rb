class CreateVisitPages < ActiveRecord::Migration[6.0]
  def change
		ActiveRecord::Migration.create_table :page_views do |t|
			t.belongs_to :visit
			t.string :title
			t.string :position
			t.text :url
			t.string :time_spent
			t.decimal :timestamp, precision: 14, scale: 3
		end
  end
end
