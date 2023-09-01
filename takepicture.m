function [ ] = takepicture( framenumber , frequency , enable_preview, foldername)
%TAKEPICTURE This function takes a snapshot from webcam
%   framenumber = how many frames to be recorded 
%   frequency = if it's 5, 1 in 5 frames will be recorded. The higher is the
%   faster.
%   enable_preview = set true if you wanna preview the cam
%   foldername = the folder where the pictures will be saved

% Close variables
close all;
imtool close all;

% Default values
default_framenumber = 1;
default_frequency = 3;
default_foldername = 'camshots';
default_preview = false;

% Default arguments
switch nargin
    case 0 % No argument is given case
        framenumber = default_framenumber;
        frequency = default_frequency;
        enable_preview = default_preview;
        foldername = default_foldername;
    case 1 % Only one (first) argument is given
        frequency = default_frequency;
        enable_preview = default_preview;
        foldername = default_foldername;
    case 2 % Only first two arguments are given
        enable_preview = default_preview;
        foldername = default_foldername;
    case 3 % Only first three arguments are given
        foldername = default_foldername;
end

if framenumber <= 0
    error('The number (arg0) of repetition cannot be negative or equal zero');
else
    % Create folder
    if exist(foldername, 'dir') ~= 7
        mkdir(foldername);
    end

    % Video preferences
    vid = videoinput('winvideo', 1); % Next line is alternative to this one if you know the format
    % vid = videoinput('macvideo', 1, 'YCbCr422_1280x720');
    vid.FramesPerTrigger = framenumber;
    set(vid, 'ReturnedColorSpace', 'RGB') ;
    set(vid,'FrameGrabInterval', frequency);

    % Preview
    if enable_preview == true
        preview(vid);
    end

    % Get frames
    start(vid);
    wait(vid,Inf);
    frames = getdata(vid);

    % Save frames
    folder = strcat('C:\Users\DELL\Documents\MATLAB\camshots', '\');
    for k = 1 : framenumber
        mov(k).cdata = frames(:,:,:,k);
        imagename=strcat(int2str(k), '.jpeg');
        path = strcat(folder, imagename);
        imwrite(mov(k).cdata, path);
    end   

    delete(vid);
   
end

end


