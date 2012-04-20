String.prototype.password_strength = ->

  min = Math.min
  len = this.length

  entropy = 4
  entropy += 2    for i in [2..min(8, len)]   if len > 1
  entropy += 1.5  for i in [9..min(20, len)]  if len > 8
  entropy += 1    for i in [21..len]          if len > 20
  entropy += 3    if this.match(/[^a-z]/i)
  entropy += 3    if this.match(/[A-Z]/) and this.match(/[a-z]/)

  return 'weak'   if  0 <= entropy < 22
  return 'ok'     if 22 <= entropy < 24
  return 'strong' if 24 <= entropy < 1000
