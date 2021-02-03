

step [:sync, :clone, :setup, :up] do
  [
    'cache.factbook.json@factbook',
    'factbook.json@factbook',
  ].each do |repo|
    Mono.sync( repo )
  end
end


########################
#  publish   (that is, commit & push if any changes)

step [:publish, :pub, :push] do
  ## todo/fix: get utc date - possible?
  today = Date.today
  msg  = "auto-update week #{today.cweek}"

  [
    'cache.factbook.json@factbook',
    'factbook.json@factbook',
  ].each do |repo|
    Mono.open( repo ) do |proj|
      puts "check for changes (to commit & push) in >#{Dir.pwd}<:"
      if proj.changes?
        proj.add( '.' )
        proj.commit( msg )
        proj.push
      else
        puts "  - no changes -"
      end
    end
  end
end

#################
#  more

step [:download, :dl] do
  download
end

step [:gen_json1, :json1] do   ## raw original 1:1 format
  gen_json1
end

step [:gen_json2, :json2] do   ## "simplified" classic format
  gen_json2
end
