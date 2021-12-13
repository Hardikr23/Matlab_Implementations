
function e_msg = encrypt(e, L, message)
% This function is responsible for encrypting a message in 2 ways as
% follows

% Creating a char array from a to z
    all_chars = 'a':'z';
    num2cell(all_chars)
    msg_array = num2cell(char(message));
    if e == 1
%         Initialising an empty string
        encoded='';
        for i = 1:numel(msg_array)-1
%             disp(i)
%           Generating random string of length L to be inserted between
%           pairs of charachter
            random_string = all_chars(randi(26,[1,3]));
%             Concatenating the actual and the random string of length L
            encoded = strcat(encoded , msg_array(i), random_string);
        end
        e_msg = string(strcat(encoded, msg_array(end)));
    end
    if e == 2
%         Initialising an empty array
        en_array = [];
        for i = 1:numel(msg_array)
%             If index of alphabet + L is greater that 26, then we start
%             counting from 'a'
            if find(all_chars== char(msg_array(i)))+L < 26
                en_array(i) = all_chars(find(all_chars == char(msg_array(i))) + L);
            else
                en_array(i) = all_chars(abs(find(all_chars == char(msg_array(i)))+L - 26));
            end
        end
        e_msg = string(strcat(en_array));
    end

      
    