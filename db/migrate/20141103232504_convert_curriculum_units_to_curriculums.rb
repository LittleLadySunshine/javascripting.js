class ConvertCurriculumUnitsToCurriculums < ActiveRecord::Migration

  class MigrationCurriculumUnit < ActiveRecord::Base
    self.table_name = :curriculum_units
  end

  class MigrationCurriculum < ActiveRecord::Base
    self.table_name = :curriculums
  end

  def change
    add_column :curriculum_units, :curriculum_id, :integer
    add_index :curriculum_units, :curriculum_id
    MigrationCurriculumUnit.reset_column_information

    reversible do |dir|
      dir.up do
        MigrationCurriculumUnit.pluck(:cohort_id).uniq.each do |cohort_id|
          curriculum = MigrationCurriculum.create!(
            name: "Rails Immersive #{cohort_id}",
            description: "will be filled in later"
          )
          MigrationCurriculumUnit.where(cohort_id: cohort_id).update_all(curriculum_id: curriculum.id)
        end
      end
      dir.down do
        MigrationCurriculum.destroy_all
      end
    end
    change_column :curriculum_units, :curriculum_id, :integer, null: false
    remove_index :curriculum_units, [:name, :cohort_id]
    remove_index :curriculum_units, [:position, :cohort_id]
    add_index :curriculum_units, [:name, :curriculum_id]
    add_index :curriculum_units, [:position, :curriculum_id]
  end
end
