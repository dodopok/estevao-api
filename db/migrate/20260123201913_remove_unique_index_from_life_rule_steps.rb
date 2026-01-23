class RemoveUniqueIndexFromLifeRuleSteps < ActiveRecord::Migration[8.1]
  def change
    remove_index :life_rule_steps, name: "index_life_rule_steps_on_life_rule_id_and_order"
    add_index :life_rule_steps, [ :life_rule_id, :order ], name: "index_life_rule_steps_on_life_rule_id_and_order"
  end
end