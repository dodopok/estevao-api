class AddWeeklyServiceType < ActiveRecord::Migration[8.1]
  # Adds support for 'weekly' service type to accommodate daily office readings
  # that follow a week-based pattern (Monday-Saturday) rather than Sunday eucharistic
  # readings or traditional morning/evening prayer office.
  #
  # This enables importing 1,370+ daily readings from the IEAB weekly lectionary.

  def up
    # Service type is stored as string, no schema change needed
    # Model validation will be updated to include 'weekly' as valid option
  end

  def down
    # Clean up weekly readings if migration is rolled back
    LectionaryReading.where(service_type: 'weekly').delete_all
  end
end
