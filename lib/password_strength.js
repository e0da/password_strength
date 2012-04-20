(function() {
  String.prototype.password_strength = function() {
    var entropy, i, _results;
    entropy = 4;
    _results = [];
    for (i = 2; i <= 8; i++) {
      _results.push(entropy += 2);
    }
    return _results;
  };
}).call(this);
