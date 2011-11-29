#! /usr/bin/octave -qf
# not an executable octave file
1;

source("extractors.m");

# this function opens an image by its filename, 
# chops it in mini-matrixes and
# calls extract_data_*() for each one
function chop(img_filename, mm_rows, mm_cols)
	# open image
	img = imread(img_filename);

	# convert image to uint32 and merge RGB layers in one
	img = uint32(img);
	img_merged = 256*256*img(:, :, 1) + 256*img(:, :, 2) + img(:, :, 3);

	# get dimensions
	rows_img = rows(img_merged);
	cols_img = columns(img_merged);
	
	# init result vectors
	data_texture = [];
	data_color = [];
	
	# begin chopping
	# ensure that the sizes fit to chop
	if (mod(cols_img, mm_cols) != 0 || mod(rows_img, mm_rows) != 0)
		disp("can't chop: bad mini-matrices size");
	else
		num_sliced_imgs = 0;
		i = 1;
		while (i <= rows_img)
			j = 1;
			while (j <= cols_img)
				sliced_img = img_merged(i:i + mm_rows - 1, j:j + mm_cols - 1);
				num_sliced_imgs += 1;

				# for texture we only need the intensities (0...1)
				data_texture = [data_texture, extract_data_texture(normalize_merged_intensities(sliced_img(:)))];

				data_color(num_sliced_imgs) = extract_data_color(normalize_merged_intensities(sliced_img(:)));

				j += mm_cols;
			endwhile
			i += mm_rows;
		endwhile

		printf("image succesfully chopped. total parts: %d\n", num_sliced_imgs);
		
		data_texture_filename = strcat(img_filename, ".texture.csv");
		data_color_filename = strcat(img_filename, ".color.csv");

		csvwrite(data_texture_filename, sort(data_texture));
		csvwrite(data_color_filename, sort(data_color));
		printf("output saved to: %s and %s\n", data_texture_filename, data_color_filename);
	end
endfunction



