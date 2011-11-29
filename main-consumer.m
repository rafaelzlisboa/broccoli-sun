#! /usr/bin/octave -qf


# given an image filename, find the N other images that match it the most
base_img_filename = input("images that look like: ", "s");
img_num = input("how many? ");

# open base image data
base_img_data_color = csvread([base_img_filename, ".color.csv"]);
base_img_data_texture = csvread([base_img_filename, ".texture.csv"]);

dir_png_files = ls("*.png");
data_results = [];

for i = 1:rows(dir_png_files)
	filename = dir_png_files(i, :);

	if (filename == base_img_filename)
		continue;
	endif

	data_struct.filename = filename;

	# open color csv file and compare
	data_color = csvread([filename, ".color.csv"]);
	data_struct.color = sum((data_color - base_img_data_color).**2);

	# open texture csv file and compare
	data_texture = csvread([filename, ".texture.csv"]);
	data_struct.texture(1) = abs(cor(data_texture(1, :), base_img_data_texture(1, :)));
	data_struct.texture(2) = abs(cor(data_texture(2, :), base_img_data_texture(2, :)));
	data_struct.texture(3) = abs(cor(data_texture(3, :), base_img_data_texture(3, :)));
	data_struct.texture(4) = abs(cor(data_texture(4, :), base_img_data_texture(4, :)));

	data_results = [data_results, data_struct];
endfor

# sort results
[ordered_numbers, ordered_indexes] = sort(arrayfun(@(i) data_results(i).color - sum(data_results(i).texture), 1:numel(data_results)));

ordered_results = data_results(ordered_indexes);

# print first img_num filenames
for i = 1:img_num
	printf("%d. %s\n", i, ordered_results(i).filename);
endfor
