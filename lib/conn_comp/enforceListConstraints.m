function enforceListConstraints( list )
%ENFORCELISTCONSTRAINTS Checks if the list is header is consistent
if (list(1) == 0 || list(2) == 0 || list(3) == 0) ...
   && (list(1) ~= 0 || list(2) ~= 0 || list(3) ~= 0)
    error('List header is inconsistent. First: %d, Last: %d, Size: %d', list(1), list(2), list(3));

end