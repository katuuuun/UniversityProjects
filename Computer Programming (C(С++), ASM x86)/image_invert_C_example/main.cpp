#include "im_lib.h"
#include <iostream>
using namespace std;

void main()
{
	char src_file[] = "lena.bmp";
	char proc_file[] = "lena_proc_C.bmp";

	unsigned __int8* src_img;
	unsigned __int8  color_map[1024];
	BmpFileHeader im_header;
	BmpInfoHeader im_info;

	src_img = imread(src_file, im_info, im_header, color_map);

	// Image processing: C++ version //
	for (int i = 0; i < im_info.height * im_info.width; i++)
		src_img[i] = 255 - src_img[i];
	// End of processing: C++ version //

	imwrite(proc_file, src_img, im_info, im_header, color_map);
	cout << "C++ processing is done." << endl;

	cout << "Press any key..." << endl;
	system("pause");

	delete[] src_img;
}
