class EtlBook < ActiveRecord::Base
establish_connection "production"
self.table_name = "etl_books"
end


max_id =0
max_id = EtlBook.connection.execute("select max(id) from etl_books").fetch[0].to_i
p max_id
EtlBook.connection.close


source :in, {
  :type => :database,
  :target => :opac_production,
  :table => "books",
  :query => "select * from (select id,state from books order by id) where id > #{max_id}"
  },
  [
    :state
  ]


destination :out, {
  :type => :database,
  :target => :production,
  :table => "etl_books"
},
{
   :primarykey => [:id],
   :order => [:id,:state]
}
