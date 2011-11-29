broccoli-sun
============

This project is an attempt to create a nature image classifier using color and texture descriptors in Octave. 

To run it, first pre-process the images in your folder using:

                $ octave -qf main-cooker.m

It should ask for the size of mini-matrices in which your images will be partitioned for data extraction. For each image, `main-cooker` will create two `.csv` files: one for color and one for texture.


With your image files pre-processed, you should now be able to use:

                $ octave -qf main-consumer.m
                
to eat your broccoli. Uh.
`main-consumer` will ask which file you want to use as a base and how many top-match images it should return.


Please note that, at least for now, `broccoli-sun` only supports PNG images. 