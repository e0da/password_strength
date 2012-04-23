#
# These methods are derived from their Ruby equivalents in password_strength.rb
#

weighted_entropy = (str) ->

  min = Math.min
  len = str.length

  entropy  = 0
  entropy += 4   if str.length > 0
  entropy += 3   if str.match(/[^a-z]/i)
  entropy += 3   if str.match(/[A-Z]/) and str.match(/[a-z]/)

  entropy += 2   for i in [ 2..min( 8, len)] if len > 1
  entropy += 1.5 for i in [ 9..min(20, len)] if len > 8
  entropy += 1   for i in [21..len]          if len > 20

  entropy

String.prototype.password_strength = ->
  entropy = weighted_entropy(this)
  console.log entropy
  return 'weak'   if  0 <= entropy < 22
  return 'ok'     if 22 <= entropy < 25
  return 'strong' if 25 <= entropy < 1000
