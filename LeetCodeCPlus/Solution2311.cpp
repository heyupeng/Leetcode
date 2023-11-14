//
//  Solution2311.cpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/11/9.
//

#include "Solution2311.hpp"

// utility
#include "string_to_any.hpp"

#include "LCSample.hpp"
using namespace LC;

Solution2311 * solution2311 = new Solution2311();

typedef LC::Params2<vector<vector<int>>, int> Params2_vvi_i;
typedef LC::Sample<Params2_vvi_i, int > Sample_pvvi_i;

struct params3_v_vvi_i {
    int v1;
    vector<vector<int>> v2;
    int v3;
};

void test1334() {
    string title = "#1334. ";
    typedef LC::Sample<params3_v_vvi_i, int > Sample;
    
    vector<Sample> samples = {
        {2, {
            5,
            string_to_vector_vector_int("[[0,1,2],[0,4,8],[1,2,3],[1,4,2],[2,3,1],[3,4,1]]"),
            2
            },
            0
        },
        {3, {
            6,
            string_to_vector_vector_int("[[1,3,6],[2,4,7],[0,4,7],[0,1,2],[0,3,10],[2,5,2],[2,3,4],[0,2,8],[1,2,5],[1,4,9]]"),
            3406
        },
            5
        },
    };
    
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto s: samples) {
        auto p = s.par;
        auto ans = solution2311->findTheCity(p.v1, p.v2, p.v3);
        if (ans == s.ans) {
            printf("  #%d is ok. \n", s.ID);
        }
        else {
            printf("  #%d has an error! ans should be %d, but now is %d! \n", s.ID, s.ans, ans);
        }
    }
}

void test_s2311() {
    
    test1334();
};
