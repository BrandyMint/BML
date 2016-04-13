class RenameIsMaleToSexInLeads < ActiveRecord::Migration
  def up
    c = Collection.find_by_id 16

    rename c if c.present?
  end

  def down
  end

  private

  def rename(collection)
    c = collection.columns.find_by_key(:is_male)
    if c.present?
      c.title = 'Пол (female/male)'
      c.key = :sex
      c.save!
    end

    collection.leads.find_each do |l|
      if l.name.present?
        sex = Petrovich(lastname: l.name).gender

        if sex == :androgynous
          sex = Petrovich(firstname: l.name).gender
        end

        sex = nil unless %i(male female).include? sex
        puts l.id, l.name, sex

        data = l.data.dup
        data['sex'] = sex
        l.update_attributes! data: data
      end
    end
  end
end
