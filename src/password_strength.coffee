String.prototype.password_strength = ->
  entropy = 4
  for i in [2..8]
    entropy += 2
