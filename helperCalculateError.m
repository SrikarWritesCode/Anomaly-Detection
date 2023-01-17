function E = helperCalculateError(X, Y)
% HELPERCALCULATEERROR calculates the rms error value between the
% inputs X, Y
E = zeros(length(X),1);
for i = 1:length(X)
   E(i,:) = sqrt(sum((Y(i) - X(i)).^2));
end