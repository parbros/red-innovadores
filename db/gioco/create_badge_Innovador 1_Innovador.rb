type = Type.find_or_create_by_name('Innovador')
badge = Badge.create({ 
                      :name => 'Innovador 1', 
                      :points => '100',
                      :type_id  => type.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'