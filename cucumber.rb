Before('~@automatic-garbage-collect') do
  Sylvia.disable
end

After('~@automatic-garbage-collect') do
  Sylvia.collect
end