#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include <math.h>
#include <ctype.h>

static int flag_sum = 0;
static int flag_mean = 0;
static int flag_var = 0;
static int flag_stddev = 0;

static struct option long_options[] =
{
    {"aggregate", required_argument, 0,           'a'},
    {"sum",       no_argument,       &flag_sum,    1},
    {"mean",      no_argument,       &flag_mean,   1},
    {"variance",  no_argument,       &flag_var,    1},
    {"stddev",    no_argument,       &flag_stddev, 1},
    {0, 0, 0, 0}
};

int cols[100];
int cols_len = 0;
int col_agg = 0;
char buf[1000];
int buf_cur = 0;
int buf_len = 0;
float row[100];
int row_len = 0;
float s1 = 0;
float s2 = 0;
int s_len = 0;

int main(int argc, char **argv)
{
	int i, r, opt;
	char c;
	float mean, var, stddev;

	// optional arguments
	while ((opt = getopt_long(argc, argv, "a:", long_options, 0)) != -1)
	{
		switch (opt)
		{
			case 'a':
				col_agg = atoi(optarg) - 1;
				break;
			case '?':
				return 1;
		}
	}

	// column map
	while (argc - optind > 0)
	{
		cols[cols_len++] = atoi(argv[optind++]) - 1;
	}

	while (1)
	{
		while ((r = read(0, buf + buf_len, 1)) > 0)
		{
			c = buf[buf_len];

			if (isspace(c) && (buf_len > 0))
			{
				buf[buf_len] = 0;
				row[row_len++] = atof(buf + buf_cur);
				buf_cur = buf_len + 1;
			}

			if (c == '\n') break;

			buf_len++;
		}

		if (row_len > 0) // data line
		{
			s1 += row[col_agg];
			s2 += row[col_agg] * row[col_agg];
			s_len++;
		}
		else if (s_len > 0) // blank line
		{
			for (i = 0; i < cols_len; i++)
			{
				printf("%f\t", row[cols[i]]);
			}

			// https://en.wikipedia.org/wiki/Standard_deviation#Rapid_calculation_methods
			mean = s1 / s_len;
			var = s2 / s_len - mean * mean;
			stddev = sqrt(var);

			if (flag_sum) printf("%f\t", s1);
			if (flag_mean) printf("%f\t", mean);
			if (flag_var) printf("%f\t", var);
			if (flag_stddev) printf("%f\t", stddev);
			printf("\n");

			s1 = 0;
			s2 = 0;
			s_len = 0;
		}
		else // two blank lines
		{
			return 0;
		}

		buf_len = 0;
		buf_cur = 0;
		row_len = 0;
	}
}