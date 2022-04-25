function tests = depoCurveTest
  tests = functiontests(localfunctions);
end

function testExtrapolation(testCase)
  ts = [7; 1095];
  dfs = [0.96154; 0.95682];
  expected = 1125/365;
  curve = makeDepoCurve(ts/365, dfs);
  verifyTrue(testCase, abs(curve.ts(end)-expected) < eps(0));
  verifyEqual(testCase, curve.rates(end-1), curve.rates(end));
end

function testDepoCurve(testCase)
  ts = [7; 14; 21; 28];
  dfs = [0.99962; 0.99922; 0.99882; 0.99841];
  curve = makeDepoCurve(ts/365, dfs);
  verifyTrue(testCase, abs(curve.rates(1) - 0.019818051382573) < 1e-9);
  verifyTrue(testCase, abs(curve.rates(2) - 0.020869247298992) < 1e-9);
  verifyTrue(testCase, abs(curve.rates(3) - 0.020877603186905) < 1e-9);
  verifyTrue(testCase, abs(curve.rates(4) - 0.021408222116513) < 1e-9);
  verifyTrue(testCase, abs(curve.rates(5) - 0.021408222116513) < 1e-9);
end
