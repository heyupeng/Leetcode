//
//  Test.cpp
//  LeetCodeCPlus
//
//  Created by Peng on 2023/7/2.
//

#include "Test.hpp"

#include <iostream>

#include "Solution.hpp"
#include "Solution2309.hpp"

string projectPath() {
    return "/Users/peng/Desktop/Custom Project/LeetCodeCPlus/LeetCodeCPlus";
}

#include <fstream>
vector<string> readfline(string filepath) {
    
//    FILE * file = fopen(filepath.c_str(), "r");
    
    std::ifstream fs;
    fs.open(filepath.c_str());
    if(!fs.is_open()){
        // 无文件。
        return {};
    }
    string tempLine;
    vector<string> lines;
    int count = 0;
    while (getline(fs, tempLine)) {
        lines.push_back(tempLine);
        count ++;
    }
    
    fs >> tempLine;
    fs.close();
    return lines;
}

#include <sstream>
void parsestring(string& str) {
    stringstream ss(str);
    string buf;
    while (ss >> buf) {
        printf("%s | ", buf.c_str());
    }
    
    ostream_iterator<int>(ss, ",");
}

#include "string_to_any.hpp"

Solution * solution = new Solution();

void test2() {
    vector<int> n1 = {9,9,9,9,9,9,9};
    vector<int> n2 = {9,9,9,9};
    ListNode * l1 = ListNodeCreate(n1);
    ListNode * l2 = ListNodeCreate(n2);
    __unused ListNode * l3 = solution->addTwoNumbers(l1, l2);
}

void test445() {
    vector<int> n1 = {7,2,4,3};
    vector<int> n2 = {5,6,4};
    ListNode * l1 = ListNodeCreate(n1);
    ListNode * l2 = ListNodeCreate(n2);
    __unused ListNode * l3 = solution->addTwoNumbersII(l1, l2);
}

void test48() {
    vector<vector<int>> matrix1 = {
        {1,2,3},
        {4,5,6},
        {7,8,9},
    };
    vector<vector<int>> matrix2 = {
        {5, 1, 9, 11},
        {2, 4, 8, 10},
        {13, 3, 6, 7},
        {15, 14, 12, 16},
    };
    vector<vector<int>> matrix = matrix2;
    solution->rotate(matrix);
    for (int i = 0; i < matrix.size(); i ++) {
        for (int j = 0; j < matrix.size(); j ++) {
            cout << matrix[i][j] << ", ";
        }
        cout << endl;
        
    }
}

void test2679() {
    vector<vector<int>> nums = {
        {1,8,16,15,12,9,15,11,18,6,16,4,9,4},
        {3,19,8,17,19,4,9,3,2,10,15,17,3,11},
        {13,10,19,20,6,17,15,14,16,8,1,17,0,2},
        {12,20,0,19,15,10,7,10,2,6,18,7,7,4},
        {17,14,2,2,10,16,15,3,9,17,9,3,17,10},
        {17,6,19,17,18,9,14,2,19,12,10,18,7,9},
        {5,6,5,1,19,8,15,2,2,4,4,1,2,17},
        {12,16,8,16,7,6,18,13,18,8,14,15,20,11},
        {2,10,19,3,15,18,20,10,6,7,0,8,3,7},
        {11,5,10,13,1,3,4,7,1,18,20,17,19,2},
        {0,3,20,6,19,18,3,12,2,11,3,1,19,0},
        {6,5,3,15,6,1,0,17,13,19,3,8,2,7},
        {2,20,9,11,13,5,1,16,14,1,19,3,12,},
    };
    solution->matrixSum(nums);
}

void test56() {
    vector<vector<int>> intervals1 = {{1,3},{2,6},{8,10},{15,18}};
    solution->merge(intervals1);
}

static void test64() {
    vector<vector<int>> grid = {{1,3,1},{1,5,1},{4,2,1}};
    solution->minPathSum(grid);
}

static void test96() {
    solution->numTrees(3);
}

static void test105() {
    vector<int> preorder = {3,9,20,15,7};
    vector<int> inorder = {9,3,15,20,7};
    solution->buildTree(preorder, inorder);
}

static void test128() {
    vector<int> nums = {0,3,7,2,5,8,4,6,0,1};
    solution->longestConsecutive(nums);
}

#include "LCSample.hpp"

typedef LC::Sample<vector<int>, int> Sample_152;

static void test152() {
    auto samples = {
        Sample_152(1,   {2,3,-2,4}, 6),
        Sample_152(2,   {-2,0,-1}, 0),
        Sample_152(16,  {3,-1,4}, 4),
        Sample_152(17,  {-3,0,1,-2}, 1),
        Sample_152(153, {1,0,-1,2,3,-5,-2}, 60),
        Sample_152(185, {0,-3,1,1}, 1),
    };
    
    for (auto sample: samples) {
        int ans = solution->maxProduct(sample.par);
        if (ans != sample.ans) {
            printf("!! The ans is not what your want!");
        }
    }
}

static void test931() {
    vector<vector<int>> val = {{2,1,3},{6,5,4},{7,8,9}}; // 13
    
    solution->minFallingPathSum(val);
}

static void test18() {
    typedef LC::Params2<vector<int>, int> Params_18;
    typedef LC::Sample<Params_18, vector<vector<int>> > Sample_18;
    
    /*
     #284
     [0,0,0,1000000000, 1000000000, 1000000000, 1000000000]
     1000000000
     #289
     [1000000000, 1000000000, 1000000000, 1000000000]
     -294967296
     #290
     [-1000000000, -1000000000, 1000000000, -1000000000, -1000000000]
     294967296
     */
    vector<Sample_18> samples ={
        Sample_18(191, Params_18({1,0,-1,0,-2,2}, 0), {{-2,-1,1,2},{-2,0,0,2},{-1,0,0,1}}),
        Sample_18(281, Params_18({0,4,-5,2,-2,4,2,-1,4}, 12),{{0,4,4,4}, {2,2,4,4}}),
        Sample_18(283, {{1000000000, 1000000000, 1000000000, 1000000000}, 0}, {}), // #.283 |error:type int
        Sample_18(229, {{1,-2,-5,-4,-3,3,3,5}, -11}, {{-5,-4,-3,1}}), //
        Sample_18(284, {{0,0,0,1000000000, 1000000000}, 1000000000}, {{0,0,0,1000000000}}), //
        Sample_18(285, {{-1000000000, -1000000000, -1000000000, -1000000000}, -1}, {}), // error:type int
        Sample_18(289, {{1000000000, 1000000000, 1000000000, 1000000000}, -294967296}, {}), // error:type int
        Sample_18(290, {{-1000000000,-1000000000,1000000000,-1000000000,-1000000000}, 294967296}, {}), // error:type int
    };
    
    printf("Test #18. 四数和 (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        Params_18 par = sample.par;
        vector<int> nums = par.val1;
        int target = par.val2;
        
        auto ans = solution->fourSum(nums, target);
        if (ans != sample.ans) {
            printf("  The ans of #%d is not what your want! \n", sample.ID);
        }
    }
}

static void test16() {
    typedef LC::Params2<vector<int>, int> Params_16;
    typedef LC::Sample<Params_16, int> Sample_16;
    
    vector<Sample_16> samples = {
//        Sample_16(1, {{-1,2,1,-4}, 1}, 2),
        Sample_16(73, {{4,0,5,-5,3,3,0,-4,-5}, -2}, -2),
    };
    
    printf("Test #16. 三数和 (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->threeSum(par.val1, par.val2);
        if (ans != sample.ans) {
            printf("  The ans of #%d is not what your want! \n", sample.ID);
        }
    }
}

static void test30() {
    typedef LC::Params2<string, vector<string>> Params_T;
    typedef LC::Sample<Params_T, vector<int>> Sample_T;
    
    vector<Sample_T> samples = {
        Sample_T(1, {"wordgoodgoodgoodbestword", {"word","good","best","word"} }, {}),
    };
        
    printf("Test #30. (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->findSubstring(par.val1, par.val2);
        if (ans != sample.ans) {
            printf("  The ans of #%d is not what your want! \n", sample.ID);
        }
    }
}

void test148() {
    vector<int> nums = {
        // Todo
    };
    solution->sortList(ListNodeCreate(nums));
}

void test834() {
    typedef LC::Params2<int, vector<vector<int>> > Params_T;
    typedef LC::Sample<Params_T, vector<int>> Sample_T;
    
    vector<Sample_T> samples = {
        Sample_T(1,
                 {6, {{0,1},{0,2},{2,3},{2,4},{2,5}} },
                 {8,12,6,10,10,10}
                 ),
        {62,{200,{
            {107,95},{167,65},{104,171},{169,174},{139,183},{171,8},{128,130},{195,46},
            {95,86},{66,34},{174,17},{84,81},{75,47},{83,184},{67,11},{69,156},
            {112,119},{105,49},{26,15},{157,137},{157,60},{95,117},{15,1},{16,95},
            {165,109},{199,44},{29,90},{113,85},{52,49},{156,71},{1,76},{139,95},
            {140,49},{141,30},{81,179},{154,110},{144,191},{98,108},{116,173},{100,91},
            {178,120},{32,79},{165,39},{179,97},{190,10},{35,85},{142,45},{14,95},
            {39,150},{29,138},{189,85},{186,99},{149,128},{118,97},{1,66},{83,17},
            {72,42},{9,24},{87,156},{0,173},{141,5},{163,95},{43,53},{57,188},
            {69,12},{70,49},{79,197},{174,49},{110,122},{163,47},{169,6},{88,10},
            {181,143},{54,56},{70,160},{34,72},{180,31},{133,48},{181,93},{118,16},
            {95,55},{168,108},{90,68},{5,73},{11,102},{186,161},{64,142},{76,101},
            {82,38},{134,95},{164,7},{1,121},{126,152},{161,139},{116,144},{128,45},
            {64,89},{33,17},{100,58},{61,95},{191,22},{85,120},{183,59},{20,183},
            {173,58},{145,36},{42,2},{175,43},{124,163},{114,96},{98,133},{63,7},
            {139,185},{153,131},{157,106},{5,66},{45,188},{1,98},{163,136},{116,51},
            {51,165},{98,11},{141,28},{10,86},{90,172},{45,50},{131,146},{43,140},
            {176,184},{148,10},{49,197},{24,115},{155,15},{37,1},{40,134},{45,7},
            {36,129},{24,119},{120,192},{11,111},{186,172},{41,50},{196,178},{95,1},
            {121,78},{81,3},{188,54},{120,158},{182,88},{9,77},{13,183},{127,128},
            {160,4},{161,23},{123,170},{113,132},{168,162},{166,18},{181,121},{180,111},
            {98,126},{85,82},{172,167},{193,67},{4,194},{147,177},{183,92},{146,140},
            {159,50},{147,188},{187,50},{1,145},{116,160},{161,62},{173,74},{139,49},
            {87,98},{145,198},{137,142},{123,137},{80,86},{44,119},{119,100},{190,25},
            {166,70},{139,27},{145,154},{151,113},{27,45},{95,19},{110,195},{117,125},
            {94,167},{114,157},{191,103},{86,113},{171,23},{184,21},{4,135}
            }
            },
            
        }
    };
        
    printf("Test #30. (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->sumOfDistancesInTree(par.val1, par.val2);
        if (ans != sample.ans) {
            printf("  The ans of #%d is not what your want! \n", sample.ID);
        }
    }
}

#include "LRUCache.hpp"

void test221() {
    typedef vector<vector<char>> Params_T;
    typedef LC::Sample<Params_T, int> Sample_T;
    
    vector<vector<char>> m75 = vector(80, vector(80, '1'));
    vector<Sample_T> samples = {
        Sample_T(29, {{'0','1'}}, 1),
        Sample_T(51, {
            {'1','1','1','1','0'},
            {'1','1','1','1','0'},
            {'1','1','1','1','1'},
            {'1','1','1','1','1'},
            {'0','0','1','1','1'}}, 16),
        {48, {
            {'1','0','1','0'},
            {'1','0','1','1'},
            {'1','0','1','1'},
            {'1','1','1','1'}}, 4 },
        {68, {
            {'0','0','0','0'},
            {'0','0','0','1'},
            {'0','0','0','0'},
            {'0','0','0','0'}}, 1 },
        {69, {
            {'1','0','1','0','0','1','1','1','0'},
            {'1','1','1','0','0','0','0','0','1'},
            {'0','0','1','1','0','0','0','1','1'},
            {'0','1','1','0','0','1','0','0','1'},
            {'1','1','0','1','1','0','0','1','0'},
            {'0','1','1','1','1','1','1','0','1'},
            {'1','0','1','1','1','0','0','1','0'},
            {'1','1','1','0','1','0','0','0','1'},
            {'0','1','1','1','1','0','0','1','0'},
            {'1','0','0','1','1','1','0','0','0'} }, 4 },
        {75, m75, 6400},
    };
    
    printf("Test #221. (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->maxSquare(par);
        if (ans != sample.ans) {
            printf("  The ans of #%d is not what your want! \n", sample.ID);
            solution->maxSquare(par);
        }
    }
}

#include "time.hpp"

void test1851() {
    typedef LC::Params2< vector<vector<int>>, vector<int> > Params_T;
    typedef LC::Sample<Params_T, vector<int> > Sample_T;
    
    string rootPath = projectPath() + "/TestSample";
    rootPath += "/#1851";
    
    function<Sample_T(string filename, int ID)> createSample = [](string filename, int ID) {
        vector<string> params = readfline(filename);;
        if (params.size() < 2)
            throw "";
        vector<vector<int>> param1;
        vector<int> param2;
        param1 = string_to_vector_vector_int(params[0]);
        param2 = string_to_vector_int(params[1]);
        Sample_T sample = { ID, { param1, param2}, };
        return sample;
    };
    
    string samPath = rootPath + "/33" + ".txt";
    Sample_T s33 = createSample(samPath, 33);
    
    samPath = rootPath + "/34" + ".txt";
//    Sample_T s34 = createSample(samPath, 34);
    
    vector<Sample_T> samples = {
        { 1, { {{1,4},{2,4},{3,6},{4,4}}, {2,3,4,5} }, {3,3,1,4} },
        { 2, { {{2,3},{2,5},{1,8},{20,25}}, {2,19,5,22} }, {2,-1,4,6} },
        s33,
//        s34,
    };
    
    time_t t1 = gettime();
    
    printf("Test #1851. 包含每个查询的最小区间 (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->minInterval(par.val1, par.val2);
        if (ans == sample.ans) {
            printf("  #%d is ok. \n", sample.ID);
        }
        else {
            printf("  #%d has an error! \n", sample.ID);
//            s->minInterval(par.val1, par.val2);
        }
    }
    time_t t2 = gettime();
    
    printf(" Usaged time: %lu\n", t2 - t1);
}

void test874() {
    typedef LC::Params2< vector<int>, vector<vector<int>> > Params;
    typedef LC::Sample<Params, int > SampleT;
    
    vector<SampleT> samples = {
        {1, {{4,-1,3}, {}}, 25 },
        {2, {{4,-1,4,-2,4}, {{2,4}}}, 65 },
        
        // [7,-2,-2,7,5], [[-3,2],[2,1],[0,1],[-2,4],[-1,0],[-2,-3],[0,-3],[4,4],[-3,3],[2,2]]
        {39, {{7,-2,-2,7,5}, {{-3,2},{2,1},{0,1},{-2,4},{-1,0},{-2,-3},{0,-3},{4,4},{-3,3},{2,2}} }, 4 },
    };

    printf("Test #874. 模拟行走机器人 (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->robotSim(par.val1, par.val2);
        if (ans == sample.ans) {
            printf("  #%d is ok. \n", sample.ID);
        }
        else {
            printf("  #%d has an error! \n", sample.ID);
        }
    }
}

void test918() {
    typedef vector<int> Params;
    typedef LC::Sample<Params, int > SampleT;
    
    vector<SampleT> samples = {
        {1, {1,-2,3,-2}, 3},
        {2, {5,-3,5}, 10},
        {3, {3,-2,2,-3}, 3},
        {40, {3,-2,5}, 8},
        {106, {-3,-2,-3}, -2}
    };
    
    printf("Test #918. (%zi samples) \n", samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->maxsubarraySum(par);
        if (ans == sample.ans) {
            printf("  #%d is ok. \n", sample.ID);
        }
        else {
            printf("  #%d has an error! \n", sample.ID);
        }
    }
}

void test1499() {
    string title = "#1499. 满足不等式的最大值";
    typedef LC::Params2<vector<vector<int>>, int> Params;
    typedef LC::Sample<Params, int > SampleT;
    
    vector<SampleT> samples = {
        {1, { {{1,3},{2,0},{5,10},{6,-10}}, 1 }, 4},
        {2, { string_to_vector_vector_int("[[0,0],[3,0],[9,2]]"),
            3}, 3},
        {60, {string_to_vector_vector_int("[[-19,-12],[-5,-18],[2,-2],[10,3],[11,-3],[13,17]]"),
            13}, 26},
    };
    
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->findMaxValueOfEquation(par.val1, par.val2);
        if (ans == sample.ans) {
            printf("  #%d is ok. \n", sample.ID);
        }
        else {
            printf("  #%d has an error! \n", sample.ID);
        }
    }
}

void test279() {
    string title = "#279. 完全平方数";
//    typedef LC::Params2<vector<vector<int>>, int> Params;
    typedef LC::Sample<int, int > SampleT;
    
    vector<SampleT> samples = {
        {1, 12, 3},
        {2, 13, 2},
    };
    
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        auto ans = solution->numSquares(par);
        if (ans == sample.ans) {
            printf("  #%d is ok. \n", sample.ID);
        }
        else {
            printf("  #%d has an error! \n", sample.ID);
        }
    }
}

void test1289() {
    string title = "";
    typedef LC::Sample<string, int > SampleT;
    vector<SampleT> samples = {
        {1, "[[1,2,3],[4,5,6],[7,8,9]]", 13},
    };
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto sample: samples) {
        auto par = sample.par;
        vector<vector<int>> p1 = string_to_vector_vector_int(par);
        auto ans = solution->minFallingPathSumII(p1);
        if (ans == sample.ans) {
            printf("  #%d is ok. \n", sample.ID);
        }
        else {
            printf("  #%d has an error! \n", sample.ID);
        }
    }
}

static void test57() {
    vector<vector<string>> samples = {
        {"[[1,3],[6,9]]", "[2,5]"},
        {"[[1,2],[3,5],[6,7],[8,10],[12,16]]", "[4,8]"},
        {"[]", "[5,7]"}, // #114
    };
    string title = "#57. 插入区间";
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto& sample: samples) {
        auto intervals = string_to_vector_vector_int(sample[0]);
        auto newInterval = string_to_vector_int(sample[1]);
        solution->insert(intervals, newInterval);
    }
}

static void test823() {
    vector<vector<string>> samples = {
//        {"[2,4]"},
//        {"[2,4,5,10]"},
//{"[45,42,2,18,23,1170,12,41,40,9,47,24,33,28,10,32,29,17,46,11,759,37,6,26,21,49,31,14,19,8,13,7,27,22,3,36,34,38,39,30,43,15,4,16]"},
        {"[45,42,2,18,23,12,41,40,9,47,24,33,28,10,32,29,17,46,11,37,6,26,21,49,31,14,19,8,13,7,27,22,3,36,34,38,39,30,43,15,4,16]"}
    };
    string title = "#823. ";
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto& sample: samples) {
        auto p1 = string_to_vector_int(sample[0]);
        solution->numFactoredBinaryTree(p1);
    }
}

Solution_2309 * solution2309 = new Solution_2309();

static void test2560() {
    typedef LC::Params2<string, int> Params2;
    
    vector<LC::Sample<Params2, int>> samples = {
//        {1, {"[2,3,5,9]", 2}, 5},
//        {2, {"[2,7,9,3,1]", 2}, 2}
        
//        {-3, {"[2,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9, 2,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9,2,3,5,9 ,3,5,9, 2,3,5,9,2,3,5,9,2,3,5,9]", 4}, 2}
        {28,
        {"\
[5038,3053,2825,3638,4648,3259,4948,4248,4940,2834,109,5224,5097,4708,2162,3438,4152,4134,551,3961,\
2294,3961,1327,2395,1002,763,4296,3147,5069,2156,572,1261,4272,4158,5186,2543,5055,4735,2325,1206,1019,1257,5048,1563,3507,4269,5328,173,5007,2392,967,2768,86,3401,3667,4406,4487,876,1530,819,1320,883,1101,5317,2305,89,788,1603,3456,5221,1910,3343,4597]"
            , 28}, 200
        }
    };
    string title = "#2560. ";
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto& sample: samples) {
        auto nums = string_to_vector_int(sample.par.val1);
        int k = sample.par.val2;
        solution2309->minCapability(nums, k);
    }
}

static void test32() {
    typedef LC::Params2<string, string> Params_str_str;
    vector<LC::Sample<Params_str_str, bool>> samples = {
        {1, {"aa", "a"}, false},
        {2, {"aa", "a*"}, true},
        {3, {"ab", ".*"}, true},
        {261, {"ab", ".c*"}, false},
        {-1, {"ab", "a*"}, false},
        {-2, {"ababc", ".*aa"}, false},
        {-3, {"abab", "b*.b"}, false},
        {-4, {"abab", ".*.b"}, true},
        
        {301, {"aab", "c*a*b"}, true},
        {327, {"ab", ".*.."}, true},
        {331, {"aaaa", "aaaaa"}, false},
        {341, {"aa", ".c*"}, false},
        {351, {"aababcacabccbacaaba", "ab*c*c*b..*a*c*a*"}, false},
        {352, {"acbccccacccaabcc", "ab*.*c*b*ac*c*c*."}, false},
    };
    string title = "#32. ";
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    for (auto& sample: samples) {
        string s = sample.par.val1, p = sample.par.val2;
        auto res = solution->isMatch(s, p);
        if (res != sample.ans) {
            printf("! Error\n");
            throw "#32";
        }
    }
}

static void test76() {
    typedef LC::Params2<string, string> Params_str_str;
    vector<LC::Sample<Params_str_str, string>> samples = {
        {1, {"ADOBECODEBANC", "ABC"}, "BANC"},
        {2, {"aa", "aa"}, "aa"},
        {178, {"bba", "ab"}, "ba"},
    };
    string title = "#76. ";
    printf("Test %s (%zi samples) \n", title.c_str(), samples.size());
    
    for (auto& sample: samples) {
        string s = sample.par.val1, t = sample.par.val2;
        auto res = solution2309->minWindow(s, t);
        if (res != sample.ans) {
            printf("! Error\n");
            throw "#76";
        }
    }
    
}

static void test85() {
    vector<vector<char>> matrix1 = {
        {'1', '0', '1', '0', '0'},
        {'1', '0', '1', '1', '1'},
        {'1', '1', '1', '1', '1'},
        {'1', '0', '0', '1', '0'},
    };
    vector<vector<char>> matrix62 = {
        {'1', '1'},
    };
    solution->maximalRectangle(matrix1);
}

static std::string questionPathForTestSample(int qID) {
    string rootPath = projectPath() + "/TestSample";
    rootPath += "/#" + to_string(qID);
    return rootPath;
}
static std::string samplePath(std::string qPath, int sID) {
    return qPath + "/" + to_string(sID) + ".txt";
}

static void test84() {
    const int qID = 84;
    string title = "";
    
    std::string rootPath = questionPathForTestSample(qID);
    function<vector<int>(int)> createSample = [&](int sID) {
        string filename = samplePath(rootPath, sID);
        vector<string> params = readfline(filename);
        return params.size() > 0 ? string_to_vector_int(params[0]): vector<int>();
    };
    
    vector<int> heights1 = string_to_vector_int("[2,1,5,6]");
    vector<int> heights2 = {
        {2, 4},
    };
    vector<int> heights89 = createSample(89); // 259833437
    vector<int> heights80 = string_to_vector_int("[3,5,5,2,5,5,6,6,4,4,1,1,2,5,5,6,6,4,1,3]"); // 24
    
    typedef LC::Params2<vector<int>, string> Params_vi;
    vector<LC::Sample<Params_vi, int>> samples = {
//        {1, {heights1}, 10},
//        {2, {heights2}, 4},
//        {89, {heights89}, 259833437},
//        {80, {heights80}, 24},
        {96,  createSample(96), 250000000},
    };
    
    printf("Test #%d. %s (%zi samples) \n", qID, title.c_str(), samples.size());
    for (auto& sample: samples) {
    
        auto heights = sample.par.val1;
        auto res = solution2309->largestRectangleArea(heights);
        if (res != sample.ans) {
            printf("! Error\n");
            throw "#"+to_string(qID);
        }
    }
}

int testmain() {
    // insert code here...
    
//    test2();
    
//    test48();
    
//    test2679();
    
//    test56();
    
//    test64();
    
//    test96();
    
//    test105();
    
    solution->t2178(12);
    
    test128();
    
    test152();
    
    test931();
    
    solution->isPalindrome("0P");
    
    test18();
    
    test16();
    
//    test30();
    
//    test148();
    
//    test834();
    
    solution->addBinary("1010", "1011");
    
    solution->mySqrt(2173495599);
    
    test146();
    
    test221();
    
    test1851();
    
    test874();
    
    test918();
    
    test1499();
    
    test279();
    
    test1289();
    
    test32();
    
    vector<string> pizza = {
        "A..",
        "AAA",
        "...",
    };
    solution->ways(pizza, 3);
    
    solution->simplifyPath("/qwe/er/.///e2/../f");
    
    test57();
    
    test823();
    
    test2560();
    
    // 09/20
    test76();
    
    test85();
    
//    test84();
    
    time_t t1 = gettime_millseconds();
    // Todo
    
    time_t t2 = gettime_millseconds();
    printf("Usaged time: %.3f s.\n", 1.0*(t2-t1)/1000);
    
    string s1 = "qwf";
    string s2 = "qwea";
    bool res = s1 < s2;
    
    map<int, int> mp;
    mp[5] = 3;
    mp[4] = 3;
    mp[3] = 3;
//    mp[30] = 400;
    auto mit = mp.end();
    mit --;
    auto m2 = -- mit;
    mp.erase(++mit);
    auto lit = mp.lower_bound(7);
    auto lit2 = --mit;
    set<int> s;
    s.insert(100);
    s.insert(300);
    s.insert(-100);
    s.insert(200);
    auto it = s.begin();
    auto ss = *it;
    
    return 0;
}
