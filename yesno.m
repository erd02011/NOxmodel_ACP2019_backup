function trueorfalse=yesno(promptstring, default)
% trueorfalse = yesno(promptstring)
% presents promptstring as a question, and returns logical true
% if "y" or "Y" is pressed.
% PjW 090324
insist='n';
if ~exist('default','var'),   default = 'N';    insist='y'; end
if (default=='y')||(default=='n'), insist='n'; end   % use capital Y, N to insist on answer
if (default=='n')||(default=='N'),
    reply = input([promptstring ' (y/[n]): '], 's');
    if isempty(reply)
        if insist=='n',
            reply='n'; % if return simply pressed, assume "no" meant
        else
            reply = input(['Answer please: ' promptstring ' (y/[n]): '], 's');
            if isempty(reply)
                disp(' .. will assume no')
                reply='n'; % if return simply pressed, assume "no" meant
            end
        end
    end
else
    reply = input([promptstring ' ([y]/n): '], 's');
    if isempty(reply)
        if insist=='n',
            reply='y'; % if return simply pressed, assume "yes" meant
        else
            reply = input(['Answer please: ' promptstring ' ([y]/n): '], 's');
            if isempty(reply)
                disp(' .. will assume yes')
            end
        end
    end
end

% try to wedge in a way to halt a program by answering 0 or c instead of y or n
% if (reply=='0')|(reply=='c')|(reply=='z'),
if reply=='z',
    disp('-=> halting program with bad array address.')
    dummy = [1 2];
    dummy = dummy(0);
else

trueorfalse = (reply=='y')|(reply=='Y');

end