function tests = getBlackCallTest
  tests = functiontests(localfunctions);
end

function testBlackCall(testCase)
  verifyTrue(testCase, abs(getBlackCall(100, 3, [105], [0.1]) - 4.8518) < 0.0001);
  res = abs(getBlackCall(100, 1, [102,103,104], [0.1, 0.15, 0.2]) - [3.1063, 4.6854, 6.2801]) < 0.0001;
  verifyTrue(testCase, res(1));
  verifyTrue(testCase, res(2));
  verifyTrue(testCase, res(3));
end

function testError(testCase)
  verifyError(testCase, @()getBlackCall(100, 1, [70], [0.1, 0.2]),'getBlackCall:UnequalSize');
  verifyError(testCase, @()getBlackCall(100, 1, 70, -0.1), 'getBlackCall:InputNonNegative');
  verifyError(testCase, @()getBlackCall(100, 1, -70, 0.1), 'getBlackCall:InputNonNegative');
  verifyError(testCase, @()getBlackCall(100, -1, 70, 0.1), 'getBlackCall:InputNonNegative');
  verifyError(testCase, @()getBlackCall(-100, 1, 70, 0.1),'getBlackCall:InputNonNegative');
end