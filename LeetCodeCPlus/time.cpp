//
//  time.cpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/9/22.
//

#include "time.hpp"

//#include <sys/_types/_timeval.h>

#include <sys/time.h>
#include <sys/timeb.h>

/// Seconds.
time_t gettime() {
    time_t t1;
    time(&t1);
    return t1;
}

/// Millseconds.
time_t gettime_millseconds() {
    struct timeb t;
    ftime(&t);
    return t.time * 1E3 + t.millitm;
}

/// Microseconds.
time_t gettime_microseconds() {
    struct timeval tv;
    gettimeofday(&tv, nullptr);
    return tv.tv_sec * 1E6 + tv.tv_usec;
}

#if 0
time_t gettime_microseconds_u() {
    struct timeval tv;
    utimes(nullptr, &tv);
    return tv.tv_sec * 1E6 + tv.tv_usec;
}
#endif
