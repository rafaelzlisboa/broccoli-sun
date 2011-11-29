#! /usr/bin/octave -qf
# not an executable octave file
1;

# using the median color
function res = extract_data_color(chop_img)
  res = median(chop_img);
endfunction


# using 1st 2nd 3rd 4th momentum
function res = extract_data_texture(chop_img)
  res = [];
  res(1) = moment(chop_img, 1);
  res(2) = moment(chop_img, 2);
  res(3) = moment(chop_img, 3);
  res(4) = moment(chop_img, 4);
  res = res';
endfunction

# unused for now
function res = unmerge_rgb(merged_rgb)
  res = [];
  for i = 1:length(merged_rgb)
    merged_rgb(i);
    res(i, 1) = floor(merged_rgb(i)/65536);
    res(i, 2) = floor(mod(merged_rgb(i), 65536) / 256);
    res(i, 3) = mod(mod(merged_rgb(i), 65536), 256);
  endfor
endfunction

function res = normalize_merged_intensities(img_merged)
  res = double(img_merged)/(256*256*255 + 256*255 + 255);
endfunction
