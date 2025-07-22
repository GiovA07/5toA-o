#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <stdio.h>

int main(void)
{
	int fd = open("/dev/myrtc", O_RDONLY);
	unsigned char seconds;

	if (read(fd, &seconds, sizeof(seconds)) == -1) {
		printf("Error reading...\n");
		return -1;
	}
	printf("seconds: %d\n", seconds);
	return 0;
}
