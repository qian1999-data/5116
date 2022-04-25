function tests = getRateIntegralTest
  tests = functiontests(localfunctions);
end

function testAreaUnderCurve(testCase)
  curve = struct('ts', [1; 3; 5; 7], 'rates', [1; 3; 5; 7]);
  area = getRateIntegral(curve, 3);
  verifyEqual(testCase, area, 7);
  area = getRateIntegral(curve, 5);
  verifyEqual(testCase, area, 17);

  curve = struct('ts', [0; 7; 14; 21; 28], 'rates', [0.2; 0.5; 1.6; 1.7; 1.8]);
  area = getRateIntegral(curve, 4);
  verifyEqual(testCase, area, 2);
  area = getRateIntegral(curve, 2);
  verifyEqual(testCase, area, 1);
end

function testBoundary(testCase)
  curve = struct('ts', [1; 3; 5], 'rates', [1; 3; 5]);
  area = getRateIntegral(curve, 1);
  verifyEqual(testCase, area, 1);
  area = getRateIntegral(curve, 5);
  verifyEqual(testCase, area, 17);
end

function testNegativeTimeError(testCase)
  curve = struct('ts', [1; 3; 5; 7], 'rates', [1; 3; 5; 7]);
  verifyError(testCase, @()getRateIntegral(curve, -1), 'getRateIntegral:NegativeTimeError');
end

function testBeyondTenorError(testCase)
  curve = struct('ts', [1; 3; 5; 7], 'rates', [1; 3; 5; 7]);
  verifyError(testCase, @()getRateIntegral(curve, 8), 'getRateIntegral:BeyondTenorError');
end
