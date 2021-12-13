
function de_msg = decrypt (e, L, message)
% This function is responsible for decrypting a message in 2 ways as
% follows

    all_chars = 'a':'z';
    num2cell(all_chars);
    msg_array = num2cell(char(message));
    if e == 1
%         creating an index list using L and picking only the message chars
%         and ignoring the random chars
        index_list = 1:L+1:numel(msg_array);
        disp(index_list);
        decoded = msg_array(index_list);
    end
    if e == 2
%         if index of alphabet after subtracting L is more than 26 then
%         we get its actual values directly
        for i = 1:numel(msg_array)
            if find(all_chars == char(msg_array(i)))-L > 0
                decoded(i) = all_chars(find(all_chars == char(msg_array(i)))-L);
            else
%         if index of alphabet after subtracting L is lesser than 26 then
%         we add 26 to get uts actual values
               alpha_index = find(all_chars == char(msg_array(i)));
               new_index = alpha_index - L + 26;
               decoded(i) = all_chars(new_index);
            end
        end
    end
    de_msg = strjoin(string(decoded),'');