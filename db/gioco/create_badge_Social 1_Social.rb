type = Type.find_or_create_by_name('Social')
badge = Badge.create({ 
                      :name => 'Social 1', 
                      :points => '100',
                      :type_id  => type.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'