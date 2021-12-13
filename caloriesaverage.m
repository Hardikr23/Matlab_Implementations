
function avg_cal = caloriesaverage (cal)
% Creating a persistent list which will store values between function
% invocations.
    persistent cal_list;
    
%     Initialising the list for the first call and resetting if input is 0
    if isempty(cal_list) || cal == 0
        cal_list = [];
        
%   checking if total calories is more then 2000
    elseif sum(cal_list) > 2000
        disp("You have reached the recommended calories consumption for one day");
    end
    if cal ~= 0
        cal_list(end + 1) = cal;
    end
    disp(cal_list)
    avg_cal = mean(cal_list);
end