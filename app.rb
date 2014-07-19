
confiure do
  DB = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => '*******')
end

get '/' do
  @data = []
  DB.query("select * from tweet_table ORDER BY created_at DESC;").each do |obj|
    @data << obj
  end
  erb :index
end