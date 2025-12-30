class CleanupBibleTextsTags < ActiveRecord::Migration[8.1]
  def up
    say_with_time "Cleaning up HTML tags and Strong's numbers from BibleText..." do
      count = 0
      BibleText.where("text LIKE '%<S>%' OR text LIKE '%<br%' OR text LIKE '%<%'").find_each do |bt|
        clean = bt.text.gsub(/<S>\d+<\/S>/, "")
                       .gsub(/<br\s*\/?>/i, " ")
                       .gsub(/<[^>]+>/, "")
                       .gsub(/\s+/, " ")
                       .strip
        
        if clean != bt.text
          bt.update_column(:text, clean)
          count += 1
        end
      end
      "#{count} records cleaned"
    end
  end

  def down
    # This migration is not reversible as we are losing the original tags
    raise ActiveRecord::IrreversibleMigration
  end
end
