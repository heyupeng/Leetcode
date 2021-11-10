//
//  BinarySearch.swift
//  LeetcodeTest
//
//  Created by Peng on 2021/10/28.
//

import UIKit

/// #704. 二分查找
class BinarySearch: NSObject {

    /**
     给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        var lindex = 0, rindex = nums.count - 1
        
        while lindex <= rindex {
            let index = (lindex + rindex) / 2
            
            if nums[index] == target {
                return index
            }
            else if  nums[index] > target {
                rindex = index - 1
            } else {
                lindex = index + 1
            }
        }
        return -1
    }
    
    func test1() -> Int {
        return search([-1,0,3,5,9,12],2)
    }
}

/// #278. 第一个错误的版本
class FirstBadVersion {
    /**
     第一个错误的版本
     
     你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。

     假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。

     你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
     */
    func firstBadVersion(_ n: Int) -> Int {
        var lindex = 0, rindex = n
        
        while lindex < rindex {
            let index = (lindex + rindex) / 2
            
            if isBadVersion(index) {
                rindex = index
            } else {
                lindex = index + 1
            }
        }
        return lindex
    }
    
    func isBadVersion(_ version: Int) -> Bool {
        return version >= 4
    }
    
    func test1() -> Int {
        return firstBadVersion(5)
    }
}

/// #35. 搜索插入位置
class SearchInsert {
    /**
     给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
     
     请必须使用时间复杂度为 O(log n) 的算法。
     */
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var lindex = 0, rindex = nums.count - 1
        
        while lindex <= rindex {
            let index = (lindex + rindex) / 2
            
            if nums[index] == target {
                return index
            }
            else if  nums[index] > target {
                rindex = index - 1
            } else {
                lindex = index + 1
            }
        }
        
        return lindex
    }
    func test1() -> Int {
        let nums = [1,3,5,6], target = 2
        return searchInsert(nums, target)
    }
}

// MARK: Day 2
class Algorithm {
    
}

extension Algorithm {
    /// #977. 有序数组的平方
    ///
    /// 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var res = Array(repeating: 0, count: nums.count)
        
        var lindex = 0, rindex = nums.count - 1
        for i in 0...nums.count - 1 {
            if abs(nums[lindex]) > abs(nums[rindex]) {
                res[nums.count - 1 - i] = nums[lindex] * nums[lindex]
                lindex += 1
            } else {
                res[nums.count - 1 - i] = nums[rindex] * nums[rindex]
                rindex -= 1
            }
        }
        return res
    }
}

extension Algorithm {
    /// #189. 旋转数组
    ///
    /// 给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。
    ///
    /// 进阶：
    ///
    /// 尽可能想出更多的解决方案，至少有三种不同的方法可以解决这个问题。
    ///
    /// 你可以使用空间复杂度为 O(1) 的 原地 算法解决这个问题吗？
    func rotate(_ nums: inout [Int], _ k: Int) {
        if k == 0 { return }
        
        let kk = k % nums.count
        
        // 1.
        for _ in 0..<k {
            let num = nums.removeLast()
            nums.insert(num, at: 0)
        }
        
        // 2. O(1)
        let sub1 = nums[nums.count-kk..<nums.count]
        let sub2 = nums[0..<nums.count-kk]
        nums = Array(sub1 + sub2)
    }
}

//MARK: Day 3
extension Algorithm {
    
    /// #283. 移动零
    ///
    /// 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
    ///
    /// 示例:
    ///
    ///     输入: [0,1,0,3,12]
    ///     输出: [1,3,12,0,0]
    /// 说明:
    ///
    ///     必须在原数组上操作，不能拷贝额外的数组。
    ///     尽量减少操作次数。
    ///
    /// - 链接：https://leetcode-cn.com/problems/move-zeroes
    /// - Parameter nums: <#nums description#>
    func moveZeroes(_ nums: inout [Int]) {
        
        let count = nums.count
        var count0 = 0
        for i in 0..<count {
            if nums[i] == 0 {
                count0 += 1
            } else if count0 != 0 {
                nums[i - count0] = nums[i]
                nums[i] = 0
            }
        }
        
//        for i in 0..<count {
//            if nums[i] == 0 {
//                count0 += 1
//                nums.append(nums.remove(at: i))
//            }
//        }
    }
    
    
    /// #167. 两数之和 II - 输入有序数组
    ///
    /// 给定一个已按照 非递减顺序排列  的整数数组 numbers ，请你从数组中找出两个数满足相加之和等于目标数 target 。
    ///
    /// 函数应该以长度为 2 的整数数组的形式返回这两个数的下标值。numbers 的下标 从 1 开始计数 ，所以答案数组应当满足 1 <= answer[0] < answer[1] <= numbers.length 。
    ///
    /// 你可以假设每个输入 只对应唯一的答案 ，而且你 不可以 重复使用相同的元素。
    ///
    /// 示例 1：
    ///
    ///     输入：numbers = [2,7,11,15], target = 9
    ///     输出：[1,2]
    ///     解释：2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。
    /// 示例 2：
    ///
    ///     输入：numbers = [2,3,4], target = 6
    ///     输出：[1,3]
    /// 示例 3：
    ///
    ///     输入：numbers = [-1,0], target = -1
    ///     输出：[1,2]
    ///
    /// 提示：
    ///
    ///     2 <= numbers.length <= 3 * 10^4
    ///     -1000 <= numbers[i] <= 1000
    ///     numbers 按 非递减顺序 排列
    ///     -1000 <= target <= 1000
    ///     仅存在一个有效答案
    ///
    /// - 链接：https://leetcode-cn.com/problems/two-sum-ii-input-array-is-sorted
    /// - Parameters:
    ///   - numbers: 非递减顺序排列数组
    ///   - target: 目标值
    /// - Returns: 以长度为 2 的整数数组的形式返回这两个数的下标值，下标 从 1 开始计数。
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        if numbers.count < 2 { return [] }
        var l = 0, r = numbers.count - 1
        
        while l < numbers.count, r >= 0 {
            if l == r { l += 1; r -= 1 }
            
            if numbers[l] + numbers[r] == target {
                return [l, r]
            } else if numbers[l] + numbers[r] > target {
                r -= 1
            } else {
                l += 1
            }
        }
        
        return [l + 1, r + 1]
    }
    
    // MARK: Day 4 - 双指针
    
    // MARK: #344. 反转字符串
    /// #344. 反转字符串
    ///
    /// 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。
    ///
    /// 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
    ///
    /// 示例 1：
    ///
    ///     输入：s = ["h","e","l","l","o"]
    ///     输出：["o","l","l","e","h"]
    /// 示例 2：
    ///
    ///     输入：s = ["H","a","n","n","a","h"]
    ///     输出：["h","a","n","n","a","H"]
    ///
    /// 提示：
    ///
    ///     1 <= s.length <= 10^5
    ///     s[i] 都是 ASCII 码表中的可打印字符
    ///
    /// - 链接：https://leetcode-cn.com/problems/reverse-string
    /// - Parameter s: ASCII 码表中的可打印字符的字符串
    func reverseString(_ s: inout [Character]) {
        if s.count < 2 { return }
        
        var l = 0, r = s.count - 1
        while l < r {
            let temp = s[l]
            s[l] = s[r]
            s[r] = temp
            
            l += 1
            r -= 1
        }
    }
    
    // MARK: #557. 反转字符串中的单词 III
    /// #557. 反转字符串中的单词 III
    ///
    /// 给定一个字符串，你需要反转字符串中每个单词的字符顺序，同时仍保留空格和单词的初始顺序。
    ///
    /// 示例：
    ///
    ///     输入："Let's take LeetCode contest"
    ///     输出："s'teL ekat edoCteeL tsetnoc"
    ///
    /// 提示：
    ///
    ///     在字符串中，每个单词由单个空格分隔，并且字符串中不会有任何额外的空格。
    ///
    /// - 链接：https://leetcode-cn.com/problems/reverse-words-in-a-string-iii
    ///
    /// 写在后面：
    ///
    ///     解题方法：
    ///         - 双指针遍历字符串。（当前方法）
    ///         - 字符串分割倒序拼接。
    ///
    /// - Parameter s: <#s description#>
    /// - Returns: 反转字符串中的单词
    func reverseWords(_ s: String) -> String {
        let length = s.count
        var newS = ""
        
        var nIndex = 0
        var i = 0
        for ch in s {
            if ch !=  " ", i < length - 1 {
                i += 1
                continue
            }
            let startOffset = ch !=  " " ? 0 : 1;
            let endOffset = i-nIndex
            var jIndex = String.Index(utf16Offset: i - startOffset, in: s)
            
            for _ in startOffset...endOffset {
                newS.append(s[jIndex])
                if jIndex == s.startIndex { break }
                jIndex = s.index(before: jIndex)
            }
            if ch ==  " " { newS.append(ch) }
            
            nIndex = i + 1
            i += 1
        }
        
        return newS
    }
    
    static let t557_t12 = "@$s#^fcfavksifsa$vdi@*#xjj@iyfu(yr six)iukijr*h#zpj^&x&zbkrltog@mk#wqu%pi^a#d&*^ebjplgr$#afzyswyr!lst! e!cpcialx*hcqscwos)ap@ibtd!%(*# ipejppx@i(drwy)yzun^!#kjmqwpw^erb!pvvlx!hsvh^)&$zfyk%o#@kvktjl@wc^gleh%ak#qw*i^hv)e(^tx #m!h&trlvrvbnkxsspe%g&j#ktv*$ctqzlmpzt&d%y^rhv* (*hsvc&r myw^wd!kocbvfw@lgw!wpi@!*e&pkdtzvyhmuf*nysayisdayfj)cgf)ek%d^lg!xqkwt*axpivbnsuv$!ub c!&$xgwpbmef$h!*ab%xdubkzgzqwt*fbwfmdklkwe!ivqj^fc)i*kkxyp q^*hlixks!daq@av($!!mgt)tp@oroligbh*ki$pfgmjhmjstx*^)vzkhx$&wkrep@m*ekabuz(ery $nxnuojpuvhdws(*$%r &m&#&mbjn)qq(a$v)tj(bis^aeu$w^o)tefqb^&)o#qha!ryaomldm *b$s$p odjfdhm%&lenscf%j&n) !udk)(qdaruvuwjzlo&%@^$tdyij)ejjaue^bk r%$vnl(ntlcyyrd)yaio%f@flw#f%)^ssg*j$wdbwtbdemabas@tbg%vwh%vezmq ch*l)^gfj*oygdxdzsa#x!ajuecn)fb#w#!^sarranot^!pd&crx$zmu) @t^(@^!c$vahppwvzyo!b^r*nqirp)wo^!@@uzc@ @kbfvz!e#ch)p&*cb%ntf#gtl&yhotxxuw!qx*maowsclenlvxa&m)&n!zw #eb^)uo%orkqr)ja!lv%vtpcwbanrdbm!)u* h((v^appjjtxw)@g@xumbd)!hkkjft@qr$%v%f@xotitvb%g)y^%uinkzs)g&signx^ln(g(pmqfqw(binipjxh!ijfcrr@*a#@k rallve$(hme&gqiddczx%e)jzm*sj%xjl!zbnfh#n#e^qy*l%%uhjiq)bj(d^v^qjhjs&nth&vk&tn&dh##atx f^bfuiouarc !#trgshnipa&afilhgv&@rg!avktl@vz*lrqw(pa@z)*^(ynz(mxv&l^)(hjfhjwq@rtxa&@kjpthfz!pk!nvluzycw^%wp #)ajnryg!xcu#a keb*!y%ly&bm%^ $np@ftngyf$ye$jeyt)m)eo(ytpsm^ukmcq)olp(ttrnqqjk f^m!!zgj#(py%gw^zhms$t!jieqc@$etd^)zuau%yck%iaq@ky)swicp*y&jwqsodmo%&b!#dutum$%*ez(qbrm*egg !lk^kxxpy* h&kzxnc@bj*&c(cuvb$qo%eth w$dxb) sia*(vfwwpvvhokcgwmlur*^xv)p!(&zh&v^zszch*@aawkucbp*znxu*e)bjaivh)^#azgi)t@olp)g#gcd$ass#vsx*nz ssmd&(@ydr&u!tdk*a(*lo%*hl)#ob%%ep#m@ygx*cr@e#p aaxydfsq!)mj#c(iyou@fjpq&twgvdemagbq$dasnt#jklyt(upc#a!jxet^w^g)nuass!!zvrbicggazfbn)e# ()rznfuqamcim@$dxditeciki&&st!i^gmvo#^d^k$ctv n^srj(ykm)pov$caq%pcjw*ie%iphj!yam kw)wrhrnsg%i^wgi$cw)dwb%vkj@*q(tc&#)$ygltzzrq&g&q*uhr rukl&xkoumqrislbtpf)efy!fopx*f$itksvx&^(bwj%!tndhoxpr*ur)obs*^yrcd^%xsdmahd rzv%h@^lg uhsoyeyl#d^svu)x@xxlc$* zi#^dz$ !hw(xqzep@!iqa%)&%yy!t^spgyrtufq)uy#(ldkuryg)n$!foyphxwq!dg!xuci#nu ihtu&lacipf@$&ijk!fng! fe(u(b@jq$(&)muk!oucvuojdz)&gaz#qpj^)gbmtl^yzjyatj#ymqcfegxcxhroomjomzubl$ttl)azrqdh aoturk)a@hvlvfqypdyo@dacymrfbfdsac&ngklwmr##wxhkvbsogtndq(n&s!b$i#%^@ali@wdgq u$% *gvtjcmofi%n^xct)v!fgl#cv)@nhit$ml^#l#o*q**lv^%mm$&o($%@qa l(zixojc(zv!*qe(((%*tftb@@gx$huf*%d)k(q$i!ohve@kg!(jg$tvp#gwj%owtlq^lp%%joxf)!bm#bl$##^e@scdm zw$gtx t@mp$p$)gmt#cgnvpf%s%cyn@r$c(^vprajsunv)gw q%)xk@x cj#kdg*$se(iugvgfjq^azzg%#yupq&ibsoz%$!^fsv*amf(@g%*lisdctktvpez(#wyehrr*o^(#l(%)xspn&*)t&kt &* o%ypgr#@ugxa#%arg$sxj)zits(*)xltfhu*crtzh%syyoth&#eh#p&j$sxrxn(&hcvdj#g&r)^ jc xv@wlmh*fq^spf&(v^#&fa@cn%(abzd&ldc$!b^n(tyxal ^av##xktk^ru$ o@g)kazhcetccdih@$fkvepylvqb#pqiglozna@bi* uryb^g u*clcjvoodyarb)h$byev*jrli(fq^&y!%(mwx!lgrtelx&sfhip!r#glbvxi@okjuvhrso%!dx@v!l@s&bocw zbegjpvxl^gcjei*)ymcj#lzohxuy%^howz@^rksw@zipjdq!)rb)!&)lyn^#%g$emvnt!pl xeznx(e%aa*n(nyeo^^##^gut@nlwyc@hag#jlujmj#l(hatrgsxv^einslg$^@qxul@clchp)cqyxgd!ycgwfbrz(i%g)rz lhhw(hsxsdecspshps#)icut^b$hpbybtfbt%$e!s$w@onmhf#o!poudqrmd*#jvpfkr#@$!mt $s(qqaia!zo*ffmzie)@r*&&psv)pzr#t^!aohuqg)^ap$ounzdf^sb^zsn(frt@w%%by^%tn$l &orbwidbbkvmgtspd%qznak%n%bz(&jgvc!!whigexk)i(udiw@u)cja)&k@b!)%svtvz^$p^*w(%e #pbrolodxdwa(ytynlrw(j@( fx*bk)t(!n)kcamqk%lysij(a$*ucmvvaruc!%h)jq(&$dpwrz(f*)md(@$sfpnquqedl%%!mlztg!q)ii*%oheqt sqwqszzpep!%^xkff#w)ittkzphbztsmxe!idgv(@k)bsnjfc($&l@tyqgj iawlmwrtv@f&!nan mpqz(kgtinj)sahif#$zlxxe*uih$yqf!^bedrh!*g#!g)v$gy!^d^d(vlzr^ay) sav$bc^e%li%h(ke$la^ky^ughyk m(!n**qsg )n)vpveplytkwiuph^x^kntp!$sw(x)!q!e)h^e m!i*pqtnm)omtccqnz@nlwpcby^z(k)prgechulximnjin&mbo@)fjj(&w uwwoflpt)$!onrh!%(cp!mqom@bwl(gns&(#mku$movqmrxeqm!f&n#)#ii%!i(ba#piqnhj$!fraqwroloazy^&bqzfc ogkpv)cbf!! iw@u%cadomnfroyii*b urrdfabhurk(ejkrzrkh&!ljuhoe*w^*#&t(#tk(d##lxt*cqgsh@*^z!hq&ba)eytmdb*)gyxg^gier(n$ltv#n$qth d%@(zkv(nz)v(!zdzhl dj!)gkw)# %vp*gg^ivh##!#!wumhzi(dcv@dx^!kehzf^u@#wct$l%k@ph&@riuslhd *vy(dwzp#dgmh&laj!vv#gyhiym!!xpg#w^!itg%eo)w#h&gsol au$a#bmp^r&!#@r#jk)hxandbx(#urhe%a)&)qah!cmj&rlbhbl@kxfmiijs@vjkbn@vctx&$&fwswqmu#^$vcwm@y!#yv!sbo$ t#mjbrj%ejkjm%j(nmohgwwhjm*!nr mzmzt##%*&fc(sdxi!bqa$dgttbcre$&#ahid%ya#gcitwv b(aqfqwb&iru(vvqkyqfxjetnhsmmnlzk*bjbi*&%fmy#dr$tfzsdg#dogdelseq(rxov!zwn#ztmpetpft$qhs@p)# hzabtcd$ibnp*a#j #nip$hwgojijvro*vsukz%mskx^($&b@cyj^m!olli*vpgcfcja#d&vqbehjh%cwjthmngnufmquyauk k%sg$^zjkyygchqc*akhyp##z&ktcc^c#*x(b&fmaql)f tam%im(wixid^(^l&&^%yqljyq@g$iffof!!bj#@fyc@dbc$cbhmyqn#)xw(inkpzpmoqewmfbl)vakb^$ uc^ecoebk(w@oa#*%k%ks!mz^$zu@$*lkfu$fqawus#qxfvo)jouuob@omx(xx*kzmoj%tnq^bf*z xjuvonq)qa!uzafp$^kh^v&f*oilpyq$a!got&eh!wvf% etm$*)yybqnobyxkkfytzipokzfwcpdmfyxzfk&pbhwh)eie!u&ip&athcgu!d!od$sxbs^vt*)p*xy(v#tk@spk(&((dipnm@y g *e#xl)umtc$)o(xa(b#nvi%zhwk%(irenlkxti!ibizlbn^rizjwuqj%gezxmkohqw*()vcx@)ted$mwh&tk(%c qwx)jn#md$#hdnc@snb@tidzvhzjn#&dmwsgy(vcxbimqkk%z rhmr^trzj&@hd@gdrcufrh@q^hpm)drhv$)o@p#bsnvk!@bytj)o&x&ju%f&@k^^yjald$p^$vkkkxwy*egs@^k)rffke*$wr ckfo#qx$%hvu&!chm@s^ )lkh#yssp@rqdodxb@q@(*rdhtgl$yfpw&%vguar(swi%u #rtfvnsrad)#pagm%bjcpkzcd&i%yedy#uh$lga(qmvu@scqfy)jg*#!@h)exks#cunhm)#bxykb)^so$)*m$dc%nz*yf!djri qgvfei!)rzzl$nwh&cty*wcbx#sirgxpefw%g^zmb^^^!jzeflmxo$ *!lowhcoob@(niuoqpd^!yghtnoq!*k)bib(e$xegxnvn$u$dn)sz)do&xjrxmbl!o%ko!psy$i$ezgqu gzes&gmsq!rz!qs$mk$jeg&j&!zv^^*jh*kxk&a)rz^fae#dz*!*ritxq(qi%z@@g&^xx*ge%te@sksizk j%syy%)zpnpy*huzm#u^!xax!!rln$e^vscd!m*vn)srz^v%u msu%$d%o$b@^oouo&k!vyata(l^rrxxrtdfm*b*l*)@bovq@ngix#!&(cyrgeysbq#r&wktszplluabgh(vf*wjr tl^^fqwsy(aw%cdf&isn(t^qizjk#x(nenaej%up!ptojehy)qxnnfe%wmpioy(y%bt rk(kjov*dtshj#w*ukpti$)shp$homa^$%*y!dtn$rz^!cxh!rtclvkb$s@hbb#b(g oe^h%s(&ij&*v(ec#md&pvkj@$u!%*cdx$(u)#cjih%oy#q*u#s^lwd o@q%)@aol$y%nr@@fcupdajflvk@&rfkbfzsk%@pz!bi$%gt^ioyluamg&u@oyts *l av$zw@$m jqgi^x!kh!syh@^iar^em*%j*z@ tlnngbxz)&uhis z(ljfghfskxvggjxymu!$xaog*skol)(@tul@rt&xv^) od hhs&l#pjeg$u!bzmghhxpv)ukrq(vc#! ka#a^xbcwh@ghaspdrizhp%io$*#db@gc*&ar$nwtmr)n*fljd!#yoiy(bp^gzas(&smeusvdjq$@@uyonhwy%ttim kwtzxpv*brv@nxyehjc vq)wmzttsaisn^qkkk$qh@e&nbiheiohwxiwb@vjnmylo(oswg)($a@l&uwlwgzlpgl ixab#qi@(aiqj%ocnx&oz*l )wobuqvu&dy*aa(%jwvbkjb!wmb*hghroifkienrd(kbtvqj@oavkoyfs)v$**c@^aj$)bkw%zez)zozf@n(gio #y^!yfrlkedgzjdbqhqgjptnx^@(&!vvbs%fz@wpkf$oo)^xcrme%%yig !j!rcc&%t)p!w)ezjj@a*&)*v^e ^ntw^#yjbhl%nuov)tbrt&^iveb)wodcllcds^jsbzycbl^udsq (d)vif&hm!mnlcc&gxgp()%km!^@t^qo@j%psdtobsrcvw&sfhshjvw)*trsifkc*dk^he&qot**!&vuui#o%z)!*dm hofbgtpupjgkgu&)@&bpfcc$gak*n%wwwaycu(l!vl$^o)^&#gcohilxmtxsw* r^q*@kshzdcbv@mv***cysyh%fq@c*zgrp wghpqfqtrps%w%yxc(zb!%oa^*xwouhgawxjut%fsj&qb#way*)u#$uq$ro#vpupogppu@$le&rduedjtfm)@^wuwzsfle &vpgts@e%%^zdkhjhz@p%nrwf(c(hxk#f!& ndtc(vfm&n&toae@v$p%jyd%jgxayf@cwj%qn(xfze$hlilspr*$^qfys#kxcrakfk(b!ey!gbhq&dvk%(#cneeezfj$mh lytjmwbvvyo%&acwf@y@z*z)is(^$ *ayqaxi#ul#$^shxaoefaoge$yv(#sh#^*git#rl*pthvlb^!k*&rtyzvitasj#guiw*cfyg()ipezpj bk*b&pupghef%dbnrg#lnrt(obzpxg@*@zlieafx$wloemsod$vcifut@uthio)iyhpbrinwqv)du@z^ &pdcrdtf*&jtcnnd%ehlzfhwyjoecq)^qchbi fnv^^x(tpzrkfzhvg@im^cpciuw)v(dni ambwbulfug!&*l(c@#nfanp!l)m!pdbmtjdblxtreadkglbtdlmiko*i(doi$ )mxlraeg(*cjg@!q%(yk(f&o*n()cny@u^@#nk#cygcv%v&vy#k^cy#todc!&rdyciozzf#@kh cxet@kixnmnvclxn^h@vy$myg^t&baz@nyej!bu)b%)jr#p**yr#&^b@(&lc^vgjdflwlqf)iqk)$ #sjdagxk&jbgcjj$i cba!$j*^(#brkyh)yw#r%ij$hiok@rq$lmykk^k#zcaadvzdrkqpg#y$cq&)t%#&pgwryhj&(xdmonpo(j*gnd##keg!mu(j g*vs)#oqrryjx(e^soq^s(&bmrddnvm%nal#aj@^hh##vzpw$!gfe!*mscfwfe#v(&l&p)hcc#@ohx!koi&xpu mi&)bl(w)ca^%qmr$$vh*@qfir^f$colfi)avak^%wlwcewnh*)evwpum)oofff^icxcg!qpf krze$hhkvfz#tf*ku$@cuyh@apm%euagq!k*lw%t%!g(x!$*)x(rks!d*$ftooau#zd*saha&%xrodoxmclcch hpg!hjh!@jje!wiz%lxxzfx*stas$z!wjk@xup#$v*noa zhp)lqlhmknl*m$fhb#!)cwtmseysg($%fyzemoigu^w)%f@*bx)ukf!rqdnf y$cq@cugfpp^@lm!$*#ahklw)apimk)$g@onq)v(cedd*#q*d)xcd!ce#kefssdu*e(p qyfkpkfp!zlu@@r^gzdagom!fycoy%pe@jfz%vls$kyubeszv@cfddcfsk!dx*rdmoa@jgmah$%rjlbq yvj*zcasm l&^yckjlgbic)a&$j*b@wnatszwr#dqu@aw!d^ *krag@!xqlzho!ldsdg&o#e fcegopak#@^cllnvkj&ur@xbubhjbggahcbyeqzrp#nif%g%ic^!hcq#vxnpxu@o)rw%(n@jykv x(vcnxtswe&l%*v*rkemkpmi$s&&b^!jccl@rrg%lbjy)omup*tu!g$jgdqhij#(l l!wjebnyc*jqw#sj$lsytye!uo*o*dbjtpoljma@tiuzdblm@cfcaoa p*q%rvs)!!iiucsxrh^pq%ms(ly^l*(rsyrnmt(ere)&ay%glk(ydvnnmhlksx*g!#z)) $h@g(oya*cs@sop#&i^)!ywev%y!@%n^mqdavi%decmz!inc$l@etwygvzop!)hzx$yulmw)z&#wja(ts&um#xp#gxq* lkf)d#fpwcbp feuezxvzh$@#^doiv b%)hto#spr*^s)sqmfisknyxswp&dn@ u($xajbqtsmu%#bt iyu$g()#i#xkzowdqh*$f@^kf!jwitcu%fdfthcwbpu ra&zcx^#y^gn!zx@#urxky(j(dt(snctol@ncxktwkb@rjinhvll tvmlg(bru!s)vva#gb&gg$r!ae)bz*klihbeuvvzpj&l#c&hapm**^sg$(rs&cgk$vn^m*asqw )rfeuv#nlo%a!wn!byohzkmrermwru)fwqj^xydkonaknlnrgafnhsl iwkzltyac*n@ t(x* **ibqi&cyh*(wkro^jcul^vbi#&lgrfonu)xulz%hzhy%nuq&f #!y&s#h#wu!ektx gvnheltdpkzveepxdlqg)wo!naql !ll)*nf%nmk$f)@e)uvxwsjskk@c@aqsnsi@)vxk($vz*rm% *p(!)q^ g&foclqtc#tns)j$ jnw@poz#chl*&o(s)g%jahf^!f@jh %dvnc*!tvcd#rkxqzgk)p!wfmgyo^ccz$md%a!xw))uh pt!vgwxuwzltox$t^#vwlhy )ce#h(&$ylh%s%pvni$@#q!)mostwj!cntarbf%(#iq@t#kiuxy!cyu^kz*o(po!e(rvwbrod*(^a*w$facxgwljlpav ^g%wbkwxkgi&vzp#%ugf#fbyf&@ny%z$nua&x@nkcyiz#(ec hk(bkip)joq!xqjeuzlmgr#)os**)hg!o@a*epin!e)!(r*i^^%jdqsolxp!uvlqbn%j(dp($pve gqww)wbf*mxp!ue*vvxcw@t!f%c$edh&($!v@uh#g*#znpmqoxcernj$#q%ej bmsdd!xgl*o(l*diyzvmdwab#v&msnyl&p!a)sd^fa!rbabxmwt&s!fpf)pblv*#uc(n qu*g@mvd@bowxiwy)f(v%k&fbxsmf&!@&mu*tbt$glb!(pofjpcovox!(oikdpc%(fsnkobzxvzdisl%f*xoc tnjyyfkynzipfzzt)ct&j&e^dl&cf#iq#hrygjyzb^rhhlqfmwjoxw%i%&!yapnl#zux*d*r(s^&v%l h%mfywiffwfsl*$wzgtuyq%uunjen^wuytw#)(kkh)vljlxakp( bh^#vgrak#w$^dajvij&h&zmqlug^$*ddcjdjy(c*qh%jn%t^oj& oorwmewlqplj$wdulbjldkgqp)yaktlguuupj(g(yu(w$$@mzu)bnikrzukhqhu^uxuupaqfurxu&my bzvdzqeud&x(vnmmg$gp qn!v$jb)cij$ui(pg!txqhjeeb#t$ry ihnbm#qib@(#g^zkghf#ulz^aq%^tqpb)nvpo%ex$ce$^(gu^oav)nkk)&a^jarfjfz&p^^jro*dpoq&fzwut yk#c*ret^$qvxub^b^cb@d%&kjww&qifr&rhh&uqds#c&ke#z%a^fufcauvp%xlgswnnocrrcow!jc kbm(h*hgo#%elgv#lle@#a^cy&ew#wpq!heusk#@cugv ()kcoq&wsszwafwgvsef%fd$%laet#ue!tuafckiqkkktvy$q%ebgzgx!qodnu$ys@&su(tbw(p&%fc@qqbrx&tdt*syvg *sguhq!ie s(y^tdwqtjj*kqrexn$daced$wfhc$z)nxzhimuh&wwwup!xo#(c@i(jvj%*!i@rqvplnc)jpnra*hlkb xl$jtz&qiuaolg)kw$bc*@)$aali@yqw(cd#lb&frwt#v#c^@e)!eobg!z)fk@ qgn(wbe(xkp)f%pu)%twio(zp )i^(mebfxn#kfkj@*$ajhgkrcu^y$vph cy@hr@^u!ttufjwz &q#jlfeicvwo^y&a%l)ly#rfzj^nwl%edhm($jv$svsqcd$mzbbot&na#kg&mu^&*qh*rsnvt#obsnjgxxu)!l#$%y&l@ cvehsz&nqwwakrqk^oo s&%h(oae^#twgi%v!#(dghuegzdw)lo%frph%$ur*^tbhei*t#p&um%*ffrmp@bslhd)(@m@drx%#xydgf $ixzfgaii(d cbvo!*txr^*kgmz$%(f)gopp@e)%zppw^*ntvzpih&)#a@be(shy^plrf$@#!xcf%j&cs y$bd@@yjt hc&qyf$ow@dyf@s(az$p$khhe)odqn@zl piswn*nls*(d(al%ln*n^ewfyjinnmdmja@*jphv!km*lprm%fvwlivnx)dotle&@wx&jfa#tfxr# (c#%vvoei)toq$eoeun&&to(@e!(oq&d%ymxet^dk&i)%s dvubgf!l!joqfribt(*nwcjpuweyvhwvfxfzudgjkjldz$vzl@hy$fjmzi@rkm*h#jtivuik!xip&fdqt!yb$pnc(viw!mbgvv k^qn*ydy*yan#kuhs(ihon )eyf)pqys%wb&wgcu%rtvvj@ew@tyqg)%yl#^isi#jue@ierjx^yak(y)&ee@pd*owd&mdo#)^clhyx %@tg)#*mb&cb##zjqx!(!qqd^jzj@xfm(cw^&lw%%pf)dcvjfwlvmq*cnw(vbfuxp$d#icbz&lxe*cvg#eiruy#qcnof) sj@duoy(qm&o!rz&$#%udhc#nc&%egz yekmhnc*ueb#btocsqz#ri#vdrayvakqm^b%jmq!pkadzccmaqh)*hgtx%$kcagwbwq$qle&skgi*skry(^d^lir)bx*xlc mkijgu&&z%sfm %@weeco(kktfxfixi*dxt*j#nrztkyecdh(pqa&l@%lx#b mh(g%y!lt* s&mkj$guav%t!gkjb*fhzz$!q*q^l*qtvcaci(r*ba) hzklilgwc$$*evs(rvxbuy@#j&%ciecnd@fd)vwwfdmho^(sxpenss%ti^&fcdgscng*sx!&iih v!^%@gumbdaseumwry^kqy*pfm@lyfjd)q#mtea$!w(#&rc$evk*cn&otui !y@#dgqilaoxnkyqbfty@mbgue^&l(ffjlfmas#aeug(mdiby@zubamc&(stxe$!!jrjegzirz)wc)s^xu(r%ck$mwkw qofm(d@!!qq$niprbjv ckrwxd!)clhqyqz)rvlbbq@e!hr*$qwpiza)wo#yeexepax@ys(tvmjh%b!oob wf!*pgkz$*za%%dxb@r@l &igtdt&x(@uxgukdoenv!#l!dsosx%ffn(r$dodh%f*s@ga aje)w**##@d(u^@j^lgvjkdivqt!@$fq($p()wta$jla(povwseiu!pk(ihu&md$mt%hiajmjr$ #xbb$hu!xa#@ ed)i y^x!u^jf(smbj&nbvuoq^og&bt&v(zst@u@gnye$dgd%l!!lb&i$th*@a# )cq!tj*dmcgvhdzlqs%ybtfdrh(isb)^p%b!$lks%&to@!vy()lns#z*m&))!kzuubo!wvd@ a*$gsi&!rhb*@@p^rdo(d% k^r$$%$e(&!)#l#tgr(jhz&@%p&)(r@)i(zq*uqp&qvxgayrg#c^inxuvs)h$(^w^*fpsiuoz)bplym@vkyxtbc@!h(g(&es)o@g nax)l#idq%bkow$pbax$@tucz$p##jfyseztyrc!og$vbuoafeb@pl)o%)e)q@k^hyjl#n^dw*zou#ft@!!^ )n(zoz^%s(&psgpfz$^$)!j m*#*pz*hf$j(%^l&mf$a&sdtq zrq n(g^%f&cclyvpuj%eklkbe*pecte@kme&i(@zu#g%s*pzodduluvnl!#l%r%#vt)rrd* xfo%u@!vznrr^jrh$s)&cuf)j^qv#^^%ri$m!yqmb%(cbtnthl$^uccb^^vzr #dcz!b$nxgi*%xsdqwyga^cubchzamtlq*dcdmf(dvx&gl&ygvh^f@fouyolfw*zjnl(n$pv(z()&)wxplnvwy)jc%(f#s r@br)g@ b@wf)xpdo$q dgqnn)y*mq*)xmxm*tray$hxoazgrij)t&(me&sbftctweqqw#jsri)!drl*(hpxax(&og#i$@#ba&(qr%(aqmcll&*cst^% (koii@efsi@@xc@pzngxa!fdgqx*fre&yjyz^cms dcul&fzsq@rvkjqmacvuing#pdmbm^tp@%knrnyemz@wbhlp%^vozffjfrlhu@zcqcx(zon!dvedu)vxwx^kc&kdc@$@e o#w!seqlr)fl*nwr)hmuf*v(drchg@vm%homz$(icfvvgrylob(sxq& vm!a*tk$)nb@tbwwrmx)*ky @&%*c%ztspgmbw$l!jz$gbcsr@^*$!*m&c(s@u)ztp(sahgb(!tw!a&)&nq^w)n**smb!%ynriztzlf&m(bwfu!wj#*n !w#ihvj)aolb)@*!)om(d^rzy((npqylr$ozvsf cn(shx$gkuffmydo&z$gb$%an*mjrj^uhcd)!!@vyap*cbobu)imzqz lgq%r$c&wpp*kwj#(gltiizkd)r)o)v)whj#yewxv*slsbddmyy)^gd)$f^vltqh(ibgyk#yk#fmpr mb^#aynclnjak!zc!l#jxswalnisfd&tlbfi&chkr%zmyz&^rckdcd)ccpttrilq%lq&ex(ymwzmu^m&(zom tbrxe$^)a$tyw&v@kpcuk%*%pg%wkh@qkv*gpyt!*dm$zei(#cmbtb &l^^&t@csxvko^kmokx(qizvjkj@vnl*zxkacu#f@%zub*c@#prt)gbgg^y&jz*lbj*q&ola)(hal&*c&bh@gpmd %mj)dln!aticj%vjrz(k!hiysh@ytoprqo&dgn@)uoqxjheqdtzzitazsqasb$(l@t@#v#ah@rhtn)k&nn#wvbusa %tjk!k$ybcdzcelshu#hv*d%cblg@vnkpein@h(afa@bvnluvkc$wpvjodbdpq*epbq^gpucth*fvv hfjn bw$u)tqoed!qg*%mlhq%mw#*bzfgwibnzy*fcbrcrf$l!r!))okw#lpsj&&!#*q#(v^lclmcrtp&a#cppc ujn!n!s^mdn!tj fx i q*wat#nnrotnxcp@heeo!^h)vkcvjkj##$rrzj&en$vgbh^xycb#r)iczmxl%@%i)v*t()fvg#c*#(bcow!x aka!bt!tmb*gnpma*mjs%vfxck$((bo#lh omy*b%guer#v*dstvvm(riil%rsrzg!(c&ak*!slqcl%vlo)&llf!$akp&%z(f@iepmq!@!&l#ojfer*x il@*)x)z(j*sdk*v%p&la(uzo&mu*&tzizxbph hosa@&#oxun&a%hcobd&lxresrr*w(mgcd%flkhxagoqxifa*qwex$jfti^lt z)zty%iky))^aaf(qc#t%vc@uk#rhtfh$^zzsetndj!$z@jitmqqg^@c#@mbad#&u g)i&vtcg^letobd)!ga!s$oamtnkaet&kekenrf&tk)!cfpny!fbvozlncbohbmws#gzt)e#&szv!$ ^ca%(ygbw(d&xdtfrzzeaa!scde^f*of))ey&kvma^rjk%%f))r&(ap(ywjw@##$^%msrl(pk&u!!m((g&ky#)(*rv $r#(hrnt^^ctge%alk$v%wczryawyefwg!cxytgi$($$hzm@dqqf%*xl*(x#r#txmbnot#ke!@@s!wvt@idp)rp* anjd)&zh(# yjdl#$pom(gfq^edjyo^q%x*fa*dt*o*$omdx&dvj^r! lskoxa)))rkku%jxt@jrg&w@qb!mnyvbnm)!rrm@*&yevxb*^ kc(ce&o)(n%lxkjrjrkvobr*h@ q^yo@p!&a&ecam#h*i@)hdw%klewn)nb)g$bgu^bpiyd)$@&%eleswpcbcx^^)nbsba#&^(jscq))&^vy(!l ks)%r%#)#warhs(b!s^hfgech^p%m)^%bpe!%*f wuxkvt)@wstwsxcctpsfuckq!(voqcf)ef$kfs@x*b%btbvq@*a(&hxzekzlr%dvxilmr(n(ifebbpjcklb ermm)*q%cvi&^c)mxgr)qwinn#*ccdmihmc%rotv)uh%jpaip d^(qk)#cu)iw&vebhaej(flg%m%lwiypj@ab@$uyy&xa#nzm&ry%q(t(luf#%q#ghcipid!thpw)seior^$cmctcan%b!&zm %djtocivlip@y!#%tgtsinad(o(tb@c@cycm!gea*(y#kh !&cimd@ansgvvi)zt(jt!cdwdhmopd)dk(jzdwbztu$coof%ty#b)z$l^ cokdxn)ejp(nd*a$yx*(hx)ubiesiegigwmxceegizodz&jfa(jfuyxlsldhf&ptmmrd($)t*f#xsf#*pcjs ygqfuenxptlokowglx(j!c*fn*y%^n%&wmnk%t wa#m^ac!!j%yzpyq(t@ho&wqbrn^ri%(!swnif#mcffpwqmucjw^novw%$p$&h$kll*ibsy(v^a gsjyj*(&zaic%x)vdfbblnfur*ppcft#*(zw**zgvp@u@tg$t!e&g)wfa@jsdabbq#%%gi%esgg e*^tqub%rne*(q@(ckpquygf@ciou!u*%echf#*pc&x!nmbkp$rewn(kqom#e&%yf$hgbtipmnm%ypsow hvnkm spjambyd(i&j^qn^qit&vvthus^(hzr$du@!dm)eozwfdflq*h(hy^ot ^^bnnviev@psmxm!vaan#(ifr$$$gkj$cpnkam@pcp(!q$^xro$dplejepdn@^zn@)%^^kwl dwlry)he*icqz)dr*qp$q@s(j@&fd^vp$qr$fk&**p@$crvjnrwyar*f!dcg%^ytuz#qfo!e$wtwzn( smnnl$kcqbeygollhwhrrm!$ $%tx@e%ncq$njp*hbarrclb)$oxpor&*ez% )uc@^dvjitbwn#v^esmc^dx)yzwucmv#@dfjp@l^$l&cfgoz yl)f*unagkyyppobftb!rc$#kznx&mughvwpo)l@sxwkj#urxnbutkm)jiq^l#r^@&&@(&%vmt!n@djxf)(zqeyelm#@$ei^ !pkw!jb^nm qnoh&zukh$%q!)&sq#fm@!jw^ejxj$h)(pl&acv@^ur$(hjs^upcve$cr&qxb&ba#n!%ldz&dnkycw uhuqvbxc(k*bib(#&pidh!ciefp%m^x&fm@@lpmf^chkmdj(lb^n(!fvzcbzelmjij@#( &mytzdrjjc*uptki&vw% qxf)^fdukbpuianz)vit@gi@x^vqwa)kzws!xxg&z^ox%rc)u ^%)iuk^^rcm#jxt*bchq)ytn)lvo(ycah^)d)$bg((ast%u l!xlrkkr*ywf#bgbz%tt@w(gioay*ftlqkqlm$hdbo!bal$%gqglcafcu(b^z^eix&xzxpgvt&j!qtjb%dsql! $i!yajtun!tgqpg@)z$r$ivre!fv%%(aruw)svj#vbh(mh%xdotxy&twokq#y^(#av^$i)bfx)axi!ppahrljd)kdndzcoc w(u)e(ky#qw(i*vu!eu@aoutf v^goc%mcmv)kmj(pb$#x^)ox)obinfkjjirtvt%(ez%z we*j^wf#q$kvq)z!qy@#khth(p&yz (*&kv**eeusc&uozax&vqe@#x@uh@jyho%oxnj@ s%sp$$f!o#wnxje)! jzgaisde@eykc*fdcodzyu*$chr*xzbfivuevd!v$deoo!t(*i&!wcqmaju&v@ hp tz@)zzoztya)dzskf*h@nzije@$r%rysmzqwp*hx))%qoaho%g(ldcj%#zy@a$)#^g)k$m!biy% ueult^%tgmwmct!#gj*bnxnyeq ^iztwd#h ywg^fkxbjspe)nt$&p&)^$dbelmerlbbb!br!%bd@$@)hdm!)#q%)tt&agr!*v!#(u&igk#yn^h%^) nlnv!&!j qf $%oo#yn)kn$mhvvdunr)rzjdpekso&yy#m%zebe^*k@vzgh q%)**n#gk# tmbi^m#jr)@sr^%#!hx$sk! ankwjfth@go^l)wnwoo)shs*!cbi$jjfu*ljd*^qfxdm jsei@yt@xwufnz!u$r!mxu&s!mg)r$^^ljzyufqw(v o!^po%v!nsfai@%vamzrxjj*sd^owcmvcgg(pr@*%layqr(o)#$njjuhkrrk(aux*s@pimlrwtehumuopweam!uvfj%wenn osx$mygiq)nd#@w$xwlcowy)#a!fv$il*exaqg)mbei$uc$p)agb!wpmg^a#(rs!oj(^y#ayru#mdsy*vbqz ptovb(^sdadoc&y$efccd!#@k$k(s& qrbytgin$mjr#s(f%sgs$*lis*bqs$adbxxi)f(fjys)ufiap v $@xy^@re!h#w$)$$#&vpl@pm)ofyjgv*^ts# !@^%gsohqenpomxwj#!hiw&f*v)nqtmmh%*amartqnti@*hm#^tfar%qe*xpvo&xv^zzzka nyiuhi))rdntj@&knpamuejmpxf%m*szkgzndjz)vau&o@!z)%t lwxviq^m#@gsgp!uip%vfu!r@yccgtciejtdabjhka&*hl^oerjvfbhrsk^upskdgshqaml ^wsqj^oxpan$thk*!rq#hkv^@edhmc&^)^b*tw*%anvde ^fjaw&sojf#(n(knnjphsg$u#lr)&%(qrdfe*bpaqh!nncqtofq% #ppxdbxuvx@xq*tb@&)clgy^i*oho)cumn&!yiuk#j#)dqplihzqqlb(mzoxr&%t^ah@j##zq%*^!@cfpyreqy!cjbpfiw* @gd^ar&a)hpdvucnwucyei%dwz)zzbk)tqoria@v%(eftiv!^qrwh^%hiq) tt!kc!fn##(hyv #xvmkhfmti%l*khj)n(!dcwt%u$eia^u%leg!fy(syl^owljxb*suueprezhdqui@pjt&(%^)zhc$% s#*jf$@vmzftww#()o&r&!absngz)nb)jlxm&)^zp@$deuerrvrx&ft($exrkiutsdapz^d sez ^b$vneli)rty(hvx&mon$ztivnlw%mqgorguhqps #bm@&yfqk^yfseotmvyk$k@w(hnyltepitugepm^mh)d^zaz$fcn*lm%x$l@vd(!%)mztylylieoncy^ovrv ett#at@(gamwe&j%v%c%lcxgpddcuh@vxpe^^%$jq*(wjkt)#b(g$cdqsm%azu l&u*@zwkskp$cfask$^%oxvtdsj(mkn*e%^#cm)cb!sazoziu@qii(uy(zt (# ikt*f(yuiq&!^&)czf*bivhwj)@f*!@bgn%njxuod$&hsuclw$^hkxy@%&bn$j@vwubn#uy@xbpk)uuw%oano!dt wunuudlrpyy(jby*ym$y^ku^rfok**ulmt*urhuoq)(ai)efh@%myllg*zksaazisfg nwmqxgwflkhmmdsmltbqoaywuhom&qm(*u^lf%%gygwejapys( xc^)o$m&!t^rnc(wbx&d*x(ndc^zf^j($u%epkgvxxiby)kfsmdw%yraud*ptd^(lrjdnj(*wqg@zblfddq#t @@yvrbrv^el#izgmyz(m@lp!zsxc#dge%*fjq)tpv)q%jnwopth^ggmlbzfcjtww z&gzxo*angpw& #pjgaelvygsivblrl^%h)o*bhqqnwimf*utpx*ckblaow%h^xa@xp!jcl&xt!dirlalgza&eu#we%md slckbflhujidw&d%rihy*(agka$(l)fygwnrvly%ed&&giu($lwhw*g)chcfeoycn#rlxa@akkuz$@@s($ihn!hb^%wdtqqkh%v axqk^(f^glygkj#nrg!k!(%g!o)uw&z(dyaoyqcq$v!d$q@eewo!mfyx%@fdi^dqpw@cuvqtt)upd$#i! h^n@g@f@g)bhy&af%*osilw&c$y@s#jrtlbf#(jsoledy!hksu&w@(&qry&rfx%iwq(u#dfvzkdwoeva(ef#oh) !#zpyabfvrmh*^ukw*kgseibhcwv*opo%n%schlw%mjtr*&pcv)zbev((yltr^on!th yfbjehos#&sr&$z(@idodrtmq*x$jk(nmzchsj^m^bjx$&z^@x)ugf@z)%*)(lwr^c^qmgh%tu@kzfu*#fc!vm % u&o%cfpxtm(@npof)wm!v rdi&pi%e(gdwk@s%pq@ehh(og*b&qlau&d#qsecq*twg(!opdtiy#ougo &h)q!&qeiuwt(bctgbiezmu&#nev%uw!elckzsm$gvxsybcdbdz@s*pfr(mbiw) ^cjsb)zl*tme(svaw@n&&ptfyll@jiywzt@lerjm%lx$$slgt*exfemo@i(a@j*bk!buv)a#l(fdjaa& kdyms*##z#p%&lqxmdo) (b wfs%%*ep(ufwmer!(&j#m*)uqss$$ahhyd^@ze)wt^pn)xs$mtrv^#mkqvhay*j!t&)z%&x(tt*(arej bvngnlm%^ajocfrvkk$a)hv$cdacg^s$$)tlp^bv(jmsajhowtz#ynnnary agg^*py*@cv)@d@s%ti$ur%qipqvyjzm^ddzlt!hld(uzfo (*kfba$@ gp# rp$wq*cpn%nz#)^(&xuxlaa^x(ezif$ ml*nz*$z@*^(vx!v*zsaumw&bjmd!lpwpkjj@x)@(hoijv^fvhuplx kfv)p@^jozq^otzdvx!jireh(*paa%)u%&qhbrztj&y u$p%qvym%wgir^^$%(pinhlrayc*u!)v$iu^o@ewb!$nq!&)&olcsywuglcvf(r%##tv#isjtbm!%ka tqz$d)(@xtni$)vdx$&!n#*bz^nn*^cjhoep&)) *g)&go*oo)%*nvjzx@sj)sfvl@yrh)^dshea#qjubxs)wyg*enr*ha!#o %uq^yy$zk*p!n(a!bxw$s**taz@ujh&erg)gzgprr)v(src$n^@*pc@e)pnoksmglru#!sk)&a)qlga*oc !w s^@te(!*$u$@djdw!ydzzzzaxgp!*%@a@tx!@uew%&o%(tl$h(y baz(ivenbypj(dughm%zt^^rwhjex%!$m@*%nyku@b^pgzv!j%*iqdugsxdmm#gfem*%*y$am(tms(ja#qpstnfyjr^o gdbvo(#i$vmfxypv&nblzei(zkz)r(gslcjhj$mw@y&!))&cxnlsi@smgnwo)^hwf *q%ddnmbpx^pyyimcf(tbahcannq^da@ihhgdd^srmk)@lei(bvdkueac*tsbxzsltbzgl@qcc#!ux^agunnk$(oqu (g$!g#)%^y%zxy$wz^u&f!@vtugix#kj)*zpnl&&ehl#@zllg)al#^ugymu(zq$s@jol%it%)h)^%b %t%)$izgnx(cc!doveu&cbldjapn$!q*cn^*)@&jsz&ujx^no%amqv!(sixqe&jkgexq$$xf&i!t af#^w%t(^uyae$j(rf!pp^^jo#cv)o#yv&e*f$vmkr!#c$xaciz(c)yb^ npvk(tegqv^)kc*jn@pken&#v$zls@nb^!x!jd!ff(hcqyzksydu@d^amwojz^&ryydxklx&$#mmp^ffrgb yphtbwoamc^pqs!@htnt%!asuw%#cxlvg!@q%douemfzrn*xyfma%%dp)ribe@!al bzg@uzlc)douepym&qs&tsxuf*wbwew$p&i)z%yundw$we%#lw(er(didtd!@$oet*a%jp)cy)gu )w$p^%opnio*zh@btz#jbzmm!l qx(##vj#mhvqfy^rafyhpe(ojhos!nyh@nhq^ha %c&f%)^q$qm%qstt%fuoelchjo&qo%r@h&znc)n#pzv*gv( ou*m)t*jti&p(hpeo&xe!e()nrr)jfpths#vvu&ip&q#zubi$)i!pl^knlt!ttjul$rjg$tegfjx%$^$bu*&itz n$dfvjc@rfgd!dnks$@wdcz()t@vmorwn%d#@dcba$k$ba%wee!sscg$hohc@ss@d!oepuk&)l gdlbdj^%*ei)p$y&@ k^npb)nsp i%(xfe!x%^q^w*%%f*ezmnj^!vw!*utqotbpu)pztnimy@jnbdyiz*@v@r)r@tb!r)%r#*lkee*mqve! eslu)zue(xf$xzjge^hmj)flqnxmxx^w!!edh(pg!e@s)$@vrxyy!esbkwbgrjdhj&vyjrzbzz o$!lirc!@pozqodkkslroww$nyjhrh$aaf xlhdbr&xds(al#t!zq@mqfbhzrbcois$*&jkzbkg$j(ium h)n!orqjszap@#by*)o@zzz)ovoumgcsc###!vx%%skm#nptvkqbofkpns#zfv(kxd!offz uoulo$!$)(p&^$kwnbszdsdmcu*(x)ctbeel*w$yxqu)pa@cw))n(m&*x!vyczoucpsdq((srptzhvnx&!cb imv#ulhfo wcofhs!lni$ qxxb%u^a@qqi)f$%soylz)@g#hcld#q^ezci%sv%kemj^pcsbjm%aqk%tc*uo$qvn(zjmh!o !zj@t^wajzyxvm%l(#cix#cv#l#p&!)qg)qs$^*hls!zdps#hlwo^jj)umnm#jm&itc^m#q&wg%xb!vng%$xg lvve*j%lt)z!*nqvwjrbpp$*d)ts^vzwiq^knu(ifgdecb(%!*fcc!vxjf)ohc@sbacetuuwj!tqsciryq%fbsz#y#rmfad $a!mp^mlv%wyk$kr&zo (lzviabrjq%tn)t$hujay#jcv!^vkib idh@u#la!&pxknkucql%s^h%g@#&snuhdsmavcvvj%wg@mocfyw)&iw*ak#qq&gfgy&bv)^fiz#@#n vpjg*p*onkv%h$#$sbykrmfgb#t$bp gy%!*d@ubakfskyeonj%qxyumv(iqpqzmwtfh%ycijg)*j&pnsybvxl@!xa&s%vtbztwoz pnz@tao@&nsec#r*(q!i*mp#ea@y^*rnla%cimsc)od@g@otrnpqyy%qmp^vyv#iietre(om$)#xisu)k)(^lhqg @sw@oopw*#x(@jsehyp^k(o&ukalc!#z%dx@%#mw)jkdryivj% *ull)bkz*yeswnminh%bf&vgu!sqnj^jwqdcb&wsshphy)xe%%#p)nvv%gyclexeot#l&)!jz!wcwznd^zfo!yvzslsw$u*ekbfy e%dkavjt)wfbq@f)rucys&!r(j$usi#gic@#yy)azmofp*w%%o!va$leds @df^fa$%ywbzxr*hgvwk*f@unqnhyo%bbq#it@ckp@qvkufxxhlazspc##^p!hlpnukk)%tx##^t(imwje*zut)sbo(x tf@lypjmtsqwshjpc&$h*^#q@m(nuv^uvhjwi*gffxdpp^^d*spqkqtp(wk!rctrd&oq&b%@fmmc)@)$k key$sx#(dzv^uq)dh$hsywvuek&*zes^#r#lsi*e@)gceke^qh)saw)vgdkm am@sruvhkbvmh@!kjxi$@zdn)gd#*pir%se#$va!&etty^u@(p!pfaglalhr*(obgnfddrds@ r%dqvi&r#!*e^ml##*mtvb^d)&z!aklmqut$h(trvo!oopz&pdg(^!xu@vqxwmk$!@@jimep(ioq*ybkj%gdtbgwto two$%b%dm*rcng^avl&wqr(yud ix$wj!tymrllerl ia^atsda&nvdsuik&*@af#bv paktuog%)n%b@weky(qi&^nzmoa $tcjtryxkz&!bacyr g!xqchn(p@)g*vv&setorzbm @z^ce$c*&rmtxu@(xww(@mawy^&jwitgtipij(upmgkc^rfpedn*l(e#e*ogm nxqq@px*f&vg))$a$)jp*drtnoh#&hrses)fvmcr@p*%cvr@kjdmm&q$m(bay@beb()r)*a$!kps() zl(y^isccr!a@ni*wa)d&wremfjmsif)u!#zmgwjjcca)&tk*@at#ubixratz(g(sc#)c%xpsc%%dem q^e#sgxxdjgqgj(p$zsyo*)khem^&i(vrkeapwxfrvkq a^own#auky!fvnrqc&!(ng&fm@mln!@&fb(og#wmzockb$ige&(kbn(&$&%)fif%edrkokk&tn@i*vqznz yy#xk*s^@)rfgxnpwm!#lcrzpo!ycxypiwsqojg)uak @dt^f@joksvht**j(bv&purf@^#fc*enf$kp$yw!shhfxmr%qnqhd*(pi*m#zqg^%%%^@e!keh$#ituk !%pgwrrog$asrzmol#jroj#pacweoziletd)!zhalwtyru&(#e$xai(fytyeylapdfdtsqfx%ir@wrenynl*& mj&g#hb^uf(t&chrnr*bd@ghvy*lig bkai&lnjrssg&zf(btvpwundt%jixoa^uwa!kz$mawmpq(v)xd%abgdok*#i)gjbnxjc&#b)!@&dqbr#x@keuhay)jycvs#z&lt psx$pszrgecfam@iygv%%# o(ahn^((sh!i@*ljnwip!##p h*ogk@ilnng)*ymmdhiujmf)&y*t)$q*%opx(vty(#vlsiayu#m f&hc)%@#njftshtjw*irgzl@gaz)&ro^y(k&v^km%#)zfu^gh!o)@texmpjut*#%xbsux^hbhx*g&@%c$fasqlrxfvg&*zqaqh$ (^!xp$prkp#bl*!ais!nxa#$$kx%ds!zmqauikcdzfg kpdp*^k^opfsz!nhkhjuhy*tv n qr$zjpshzabptm!m&i**g&wf(ygckhxx*(c tygyr yksjc#*c^aug&#&t@(n(#nxwzjd)bqvkpcqsj^fp@#dgp*% pop*j k!rn^np(wc&*xz%hxixaafgr@#p^whapdjuvbflk^lemfvqak*#fvqjbjv%wt$qpbg*atw)ua@wkh# x@m@b)#ibdbp#$qfe#w(cen!m#dbjpbb%(us*(f!@%izztwo^oaldxpu n!)qol*vjyvc@vxbsdhga@gzsxfj#nqwonxnf@ae&$z(*b&qdu%eky#zcykuvp$fs^k@l@fbssp*elra*gqf***^kor^*hqg tb#n(sbtq#uoz^n%&(ohnaxts#*brm)w$(ub(coil#rhnkxhwz &ngukp@ejxypb&!sa@q!)%$&i)h$u)!luxtu%qdhjltmq%b%leqq#^ls@ mi)(oyehuv%lepg^npot!ccxesvzoxxdcxjwc#j%cr@ds @h!@idtkdh@foqc@or*&$*koxmrcuno$*wb) #kooi#p!d(o!c&u!tj^#%tqqzhjrz%s%y%svd($w$zf#^h(%vihrs%k!&p$ q*fmz)wee(gw@dhcziyxt*u$cz@kjrniokepx)kud*)wzfqgek(wd*qx#&ai(!wf%pufjqjjxjj(w!*qh) rl^uex@jzk$(qtpxyyfn#^yqthvcgpeczer)lnnjf^mi%mklhcvwpbwx@tda#r@uivf#$(ak(#eq#shdkwmhvb!!v*)a!z*vy&jy *apgijr#i)q&bp*iuh&hcuvqlogjbiazlf m)bah!nchkynvwwcy!)@^qkmpe&sdkl&ljvkefd%h#rnmatm%b!eegua) ajxbnjt)eycbgkoyzszdz!s)wbsog$h^jbei$as#oxbn&frhnxhlunrtx&eeol)a%umxxthg*)%jaw)o!nks^(m pecjofzubsclbbxm$i#%asog#bb(diewe&it)rxtvgu&rfeki@$os%cp*imbh(ewabtvmh) bcg&lxz cknbf)bselcfrwfhr&k*oc!fcbp* v&u*dd%i^zoh@jfsdemykurj)f@zk*wwl#a@ mn(u^q)luz(%#lg)@%ht#hhnki@mq)yy^tqj)rwc*(jjxccthf^uv!)yzj!c!!%tiuo%la)*e#zw$f(mr@mqo jx%%oh!pbkji)qlpdm%v!znl@&bhz^)cskw*u(t#g!qhtpmavypk%s&gqqq @)%kylit%pvv*i!g#)wtq)yz!moxvk^ncvkku(b^b)xgvyhj(p%twcevcmhs)ng)qo!m^r*ai)y&c)%masvhi ld^e(j#lv*rcttwhnkf!b(mp&j%c*@%cem!fbtz&gtvvfqc&c hxllqz^s)ckqgwv(n$xtpd*pqht&h#(&c!sr$)xnpwd#f$h#yk(a)st^yer#gip%awbvnatu^l^lhqjnsbmoauqln)rlu*h%j*!@ zljn#cs^t(zzelrqx!n@z&sh@hmwkrjwu*!ew*zr%#d$n$)pyho^x^s@&j$ab##vmyagv)ii$czjju%%hbhzamt@@i*fwoeqf suyejl&et !sqkb)iix*gkwyutl))mxedqdpg^c$@nry(unf%xr#*@cdx$rmucqfneem#rza^hnf^davt^owmabblg*nw wlv!qaia&@eed^#*nxrs ob(s)c%%@kpwpgs*mxmpwnvosuof s@mnr$ws^impvj$uuosqpyrnpcmr^ycg&snna$*i*&cp&$kp@(zd @!*zbflyx*#$npeyb@kkf%)oyxmhbehlhdd!krv*yp^)&jy(cb@j#zwjzu$%v#eienof^su#uuej@@@gl(de(xa ijpilbnhosf&h!fw(dgm((tw(we*$%!$zwiegkqv$(#n^jx@p(hde ya&##e$(#m)yh*pneb@^pg$%b&*nhm&klh%ay^)%isi!@ %j*n*ibj$!^llbyifp*s)$wx^@%ymwvfoxvqplyc*ecugdf^i&qisibnvd$b&urgcogj rn(k#zjzo$al(***^oaqo( whhb@wdoo^bbbrzch%f)npij y*i*heocj&jr$%p!tbmg$d eboqyh()g(h)@wh(fnycyl#qxae%%cvruvhgxpivma!y@!huzkbu@z%wumius!ls*^yi&@^&lu!lywpduqq&rbjv!#o#l)g v%$w@smldqo()o*@!lt$^&g&i@q@ybuxi)pee$%mlh@sgjd$@k$dl^yfa%zerakjm#mokb$gvwq! uxawm$cifiwo(ae #rrjvf!dsun((!t)wgkd&pkjl!zcr%j*m^!#jv^%wduztxpf)uf)!&te*wneoxlwxwv(ryydkj(&qvb#mw$p v!nz@#v#fz%@boctohrh@lj*$@qz&tak%l^ul aajl&*dr&fc&hl!&ht #c!qf@&dfle!kfs@bzgrhn(p%#io&qr$^et iy&l$pisntycipttg*i$$kemovd)yt*utidlkczxnkh!$@uu!wtcua^!@ksf(a!kjrcl#*op!ta*ydicd$$#ss%f#(xcn *&hm(lo%( wd amr$cr$@wegkog(% d#vwr!v&%()ga*yulygc!cz$(bkqfq*iaxwv&vzxobes%kfqqibxun)reubfaq#r)d) o&&@h&avm(&o*zngt^vgziffum!()&dsdh%$nlxemus%ly$&wvw#mibmlrukbw((zc&&ci*ksvssor*jhbg#waqtv@#fxznc na)k&q#s&^ddepzj kvkytm a%b*igiiq^q@odbkk@^)jocpuy!&hbkrfbkd*%vmfk!frrftuo)p@@gzwu(j$qxeow!$rd&mq#&arvqsjexi)(@vni# l$uh$p$hd$r^ud@hympvisciwf)#(#*$r$yxudua%uh%gua*irkvhhex&jpx(bf##m@pv$r^dtobt$!**vnohtey $ic&^g(mt&#(!jb(bw*y%zybqi%cz!*g*vs)a(mmd@)%efwx*ad)$jm@a@@g%h#bq&hsi^sxhz&wkiy^kj uor^dhng#*kt$(uh&y#mi^*n^ecbokwsbuqx$rq bsqavhdvbtouop(actvbbs$lw(zvon!ib##px@np&@rq$psg^v%r*cpx*krc)nrn(g@qrunq@qup)s)zqgoc%w* r!whdpvunwtufdwl^$b#n)clfgri!)rgso%qqje kbv#*g*lwqyb@*rs us(qu)^tur((k!kvp@br&algf$a!*a$bs$qdz^^phdnn(iv*ltu#ep(&w%gg!)ka%pi u$zcw@!u!(k^u!fxm@tl!jwx&fmig ex)^drhpjgtckanitbvq%hbm^dof!w!*hym)icwo@dggbu$$@(wfgqiodpnsjrgi##$dz@wlikbtlhl kd%&@#qx(o%gqo$bi*^euuv&^u$xr!^ dhxd(^*@&j zbjk$pgbiltr^bxekk#&vgf(&g)fj!l#sbsxizgcya^&*rfkdthyj##ewydu(zjaz q@wuwn*ur*xkgale@caulmt@hnwoa#l)^h)(c%*kcmmju&bks@*d ureogkj&^r!t&c^ople#ucy(i@cd*%umow%&qspuz^cgp@elb%wgzzqyjqrlk^uz bni%k()gr*f*imaun#iso*!wbhkx&taq*w%nziyvfjiax@p@%xd!rz vg$tv!c)k@)a!^nze^a!ch(vmrrejgj&i)l*jt@helmn)icq$!gt%ezjy(w@m(bxug@%rpmx@e%t**pur*^qs#gj)i oxt(hq$k*#cpg*zzhpl(ewrndw&%yempnqjxjxv&f!%ydulycdjtrnxyy(t@eomns%%vch$ax!f&(hs*wcny#)zeddtdlb&p* ^r*c$y*#&bgy%t#)#o&((#flw)ocutd@w(izc*cg@ao@ pdpvyp*p^cgiaoz%j%zrg&bgkgusrzraqijd(i*hcgpulrljeo!upfynpztp^sskgyxr&l(we*((zytvqs% h!$ftck@&l!np#w^@^iu*@rmgsj%p@x^bajkiwnsyft%zqjc)vigaianalt vatv#w()o*xhgd(hblf(iw(w#%&i$p&m#spz^*bgebetcy*d$&grf))@gp#l)iuw*nabkdxevvu#mqa*c %sanqvxz^#jlor%l@m%btq$wlqgf%@d!cs$vcxm*@eqi^^zk& @@wz(!j&$#bmy^$dbgufkyh)z%fzfa#$$(ffehqkxi@hpfbuu)ihg!sw#ahlzjv@)vy$i@j@pevub %n@us#ta*jt&v^tqwbnb(on!mmbl)&l iecxati&k)o(^#qpefy)@&@#k&(#^mb*(lcpxiihg!cm^lp%%z%a&pv!uxp(&fsfg^&yv!%hf#*&yb*de *t$a#zojfpqk)@*sxh@#tzn*%h%%u)$pijnh#bjp%c*lteue(j%&^ gcg)a@(zlr&$ql#e%c^jodmciufapnebval%ituh#bfg&qwdiavuaqq%#uytc mouzeqcb#%nmp^vyk&)&qnx@#&jas q*gtueftym&^i^t^rrxu)!f)@$#^mtx&ulhta(rmri lh^byzlx&b%$)!t@eqxacux($!lqpgrfc#s$jf(&$h$&xg hpk&ferpenzn@nw^q@(d&^fvbvcrfs%! u!pcnew*^uybogiojhjlh#omzq*an)nim**loi#$#jbjvyda)^qv*tijuzb nfhabkaaacq#*)(oozfnbtpim$fttp$ldo@mppn@$wkw^elv*e%qr(@izxirhm&d$(@snagletlrhlgg nskbxpypr)(%((@q!pwr#%pn!aj##q$o!jzmpkm ooe&%xrk!g!kc)r@n(bwhd%ogr%dg@t )codcockvtfmh%ofqf tvk^!zpkllny#!^rayp&x)wdate!%$omkgsa#!!$xeqz*^tryo!!wgdudpjus$z*#t^(cgzjc m&z)^*udinsb@^an)wphszen*tjsj#@z*u!v@p^!w!^wosapcjsrz)xd#ij^hb&b& kvjjs%gz#lubd&q^yejje*od*%z@jvl$grz#j%u&yfr$d!xsrftro&qkur@otdu^i#o(hnob)@to zl^zh%p#pzlle!@wjbsi*quymvyausawmf%fna%%u%zztggk#)$x(nsuyz#xvfqnhj*mqhecytukw)ywsx#svas%z(t!w ue(v^a@&bu%da%ytu&qrev!#^&vvr^rt#rjxjsav)j%(*pzlehjuuqpf pqhc@*o@$sotmtyh$(#glqc ig*%g@ih#apgb&dbta&rfbixpptu&ois@sd$q(o*uf*np*dw bt!hclo**fc%morgtlpi%uwv(@v&zdhlh*mdyqrvf&*bbr(c%v$etgcjdwfzo*wqiqj)!)n*yd@ldis(tbb x*kosgjnijk%ayycaadlhkte#*)(vh%n(ynrpzvn*r^bp#cf%eb@mcjb$ni^%j%flgcnhfv!cxdyhxji)bqe#%sxhi#q nf%bndk)tmq#efftjpdtmjpmsxf#dvs&jzblsjnluanv)m!*hoxosn!ls)&khsfc%pmymyzio fknls$qe()myqqsmtnaofc#^nzq%hnan!xx(u!wo!kla&&kfa$#btm&)rqjju&#b)&ul&^foks)wk!zqww)yehwyxt!z%tc f(@$)mnecxz!#j(#kdka*z iqf(arz#!&)s%bq&rbhq%pdhs&u$hhl)pjc)xr^cs%lmzk^gp$gezizwrblccv$ a&d@^bs@!(lhdj%rcdq&z(w@wl!nuftr%@#mt!(rtk)rfgt*ge zc$mqp!lvi)$t^uef"
    
    // MARK: 第 5 天 - 双指针
    
    // MARK: 876. 链表的中间结点
    /// #876. 链表的中间结点
    ///
    /// 给定一个头结点为 head 的非空单链表，返回链表的中间结点。
    ///
    /// 如果有两个中间结点，则返回第二个中间结点。
    ///
    /// 示例 1：
    ///
    ///     输入：[1,2,3,4,5]
    ///     输出：此列表中的结点 3 (序列化形式：[3,4,5])
    ///     返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
    ///     注意，我们返回了一个 ListNode 类型的对象 ans，这样：ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.
    /// 示例 2：
    ///
    ///     输入：[1,2,3,4,5,6]
    ///     输出：此列表中的结点 4 (序列化形式：[4,5,6])
    ///     由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。
    ///
    /// 提示：
    ///
    ///     给定链表的结点数介于 1 和 100 之间。
    ///
    /// - 链接：https://leetcode-cn.com/problems/middle-of-the-linked-list
    ///
    /// 写在后面：
    ///
    ///     - 双指针法（快慢指针记录i、2i）。
    ///     - 计算链表长度（两次迭代，先长度，后定位）。
    ///     当前使用方法 1。
    ///
    
    /// - Parameter head: 头结点为 head 的非空单链表
    /// - Returns: 链表的中间结点，即后半部分链表。
    func middleNode(_ head: ListNode?) -> ListNode? {
        var next1 = head
        var next2 = head?.next

        while next2 != nil {
            next1 = next1?.next
            next2 = next2?.next?.next
        }

        return next1
    }
    
    // MARK: #19. 删除链表的倒数第 N 个结点
    /// #19. 删除链表的倒数第 N 个结点
    ///
    /// 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
    ///
    /// 进阶：你能尝试使用一趟扫描实现吗？
    ///
    /// 示例 1：
    ///
    ///     输入：head = [1,2,3,4,5], n = 2
    ///     输出：[1,2,3,5]
    /// 示例 2：
    ///
    ///     输入：head = [1], n = 1
    ///     输出：[]
    /// 示例 3：
    ///
    ///     输入：head = [1,2], n = 1
    ///     输出：[1]
    ///
    /// 提示：
    ///
    ///     链表中结点的数目为 sz
    ///     1 <= sz <= 30
    ///     0 <= Node.val <= 100
    ///     1 <= n <= sz
    ///
    /// 链接：https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list
    ///
    /// 写在后面
    ///
    ///     解题方法
    ///     - 双指针法
    ///     - 计算链表长度
    /// - Parameters:
    ///   - head: 链表
    ///   - n: 删除链表的倒数第 n 个结点
    /// - Returns: 链表的头结点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if n < 1 { return nil }
        
        var next = head
        var last: ListNode?
        var count = 0
        
        while next != nil {
            if count == n {
                last = head
            } else if count > n {
                last = last?.next
            }
            count += 1
            next = next?.next
        }
        
        if n == count {
            return head?.next
        }
        else if n < count {
            last?.next = last?.next?.next
        }
        
        return head;
        
        // 2
//        var count = 0
//        var next = head
//        while next != nil {
//            count += 1
//            next = next?.next
//        }
//
//        if n == count {
//            return head?.next
//        }
//        else if n > count {
//            return head
//        }
//
//        var index = 1
//        var last = head
//
//        while index < count - n {
//            if index == count - n - 1 {
//                last?.next = last?.next?.next
//                break
//            }
//            last = last?.next
//            index += 1
//        }
//        return head
    }
    
    // MARK: 第 6 天 - 滑动窗口
    
    // MARK: 3. 无重复字符的最长子串
    /// #3. 无重复字符的最长子串
    ///
    /// 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。
    ///
    /// 示例 1:
    ///
    ///     输入: s = "abcabcbb"
    ///     输出: 3
    ///     解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
    /// 示例 2:
    ///
    ///     输入: s = "bbbbb"
    ///     输出: 1
    ///     解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
    /// 示例 3:
    ///
    ///     输入: s = "pwwkew"
    ///     输出: 3
    ///     解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
    ///     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
    /// 示例 4:
    ///
    ///     输入: s = ""
    ///     输出: 0
    ///
    /// 提示：
    ///
    ///     0 <= s.length <= 5 * 10^4
    ///     s 由英文字母、数字、符号和空格组成
    ///
    /// - 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
    ///
    ///  写在后面：
    ///
    ///     解题思路：哈希表、字符串、数组
    /// - Parameter s: 字符串
    /// - Returns: 不含有重复字符的 最长子串 的长度
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count < 2 { return s.count }
                
        var ss = ""
        var maxLength = 0
        
        for ch in s {
            if let first = ss.firstIndex(of: ch) {
                maxLength = max(maxLength, ss.count)
                let lowwer = ss.startIndex
                let upper = first
                
                ss.removeSubrange(lowwer...upper)
            }
            ss.append(ch)
        }
        
        return max(maxLength, ss.count)
    }
    
    // MARK: #567. 字符串的排列
    /// #567. 字符串的排列
    /// 给你两个字符串 s1 和 s2 ，写一个函数来判断 s2 是否包含 s1 的排列。如果是，返回 true ；否则，返回 false 。
    ///
    /// 换句话说，s1 的排列之一是 s2 的 子串 。
    ///
    /// 示例 1：
    ///
    ///     输入：s1 = "ab" s2 = "eidbaooo"
    ///     输出：true
    ///     解释：s2 包含 s1 的排列之一 ("ba").
    /// 示例 2：
    ///
    ///     输入：s1= "ab" s2 = "eidboaoo"
    ///     输出：false
    ///
    /// 提示：
    ///
    ///     1 <= s1.length, s2.length <= 104
    ///     s1 和 s2 仅包含小写字母
    ///
    /// - 链接：https://leetcode-cn.com/problems/permutation-in-string
    ///
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        if s1.count > s2.count { return false }
#if false
        var dict1: [Character: Int] = [:]
        for ch in s1 {
            if let _ = dict1[ch] {
                dict1[ch]! += 1
            } else {
                dict1[ch] = 1
            }
        }
        
        var dict2: [Character: Int] = dict1
        var ss = ""
        
        for ch in s2 {
            let count = dict2[ch]
            
            if ss.count == s1.count {
                break
            }
            if count == nil {
                if ss.count != 0 {
                    dict2 = dict1
                    ss = ""
                }
                continue
            }
            else if count == 0 {
                let index = ss.firstIndex(of: ch)!
                let sss = ss[ss.startIndex...index]
                for chch in sss {
                    dict2[chch]! += 1
                }
                ss.removeSubrange(ss.startIndex...index)
            }
            ss.append(ch)
            dict2[ch]! -= 1
        }
        
        return ss.count == s1.count
#else
        
        var counts1 = Array<Int>(repeating: 0, count: 128)
        for ch in s1 {
            let index = Int(ch.asciiValue!)
            counts1[index] += 1
        }
        
        var counts2 = counts1
        var chs: [Int] = []
        
        for ch in s2 {
            let index = Int(ch.asciiValue!)
            let count = counts2[index]
            
            if chs.count == s1.count {
                break
            }
            else if count == 0 {
                if !chs.contains(index) {
                    chs.removeAll()
                    counts2 = counts1
                    continue
                }
                let first = chs.firstIndex(of: index)!
                for j in 0...first {
                    counts2[chs[j]] += 1
                }
                chs.removeSubrange(chs.startIndex...first)
            }
            counts2[index] -= 1
            chs.append(index)
        }
        return chs.count == s1.count
#endif
    }

    // MARK: Day 7 - 广度优先搜索 / 深度优先搜索
    
    // MARK: #733. 图像渲染
    /// #733. 图像渲染
    ///
    /// 有一幅以二维整数数组表示的图画，每一个整数表示该图画的像素值大小，数值在 0 到 65535 之间。
    ///
    /// 给你一个坐标 (sr, sc) 表示图像渲染开始的像素值（行 ，列）和一个新的颜色值 newColor，让你重新上色这幅图像。
    ///
    /// 为了完成上色工作，从初始坐标开始，记录初始坐标的上下左右四个方向上像素值与初始坐标相同的相连像素点，接着再记录这四个方向上符合条件/// 的像素点与他们对应四个方向上像素值与初始坐标相同的相连像素点，……，重复该过程。将所有有记录的像素点的颜色值改为新的颜色值。
    ///
    /// 最后返回经过上色渲染后的图像。
    ///
    /// 示例 1:
    ///
    ///     输入:
    ///     image = [[1,1,1],[1,1,0],[1,0,1]]
    ///     sr = 1, sc = 1, newColor = 2
    ///     输出: [[2,2,2],[2,2,0],[2,0,1]]
    ///     解析:
    ///     在图像的正中间，(坐标(sr,sc)=(1,1)),
    ///     在路径上所有符合条件的像素点的颜色都被更改成2。
    ///     注意，右下角的像素没有更改为2，
    ///     因为它不是在上下左右四个方向上与初始点相连的像素点。
    ///
    /// 注意:
    ///
    ///     image 和 image[0] 的长度在范围 [1, 50] 内。
    ///     给出的初始点将满足 0 <= sr < image.length 和 0 <= sc < image[0].length。
    ///     image[i][j] 和 newColor 表示的颜色值在范围 [0, 65535]内。
    ///
    /// - 链接：https://leetcode-cn.com/problems/flood-fill
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        let oldColor = image[sr][sc]
        let raw = image.count
        let col = image[0].count
        var newImage = Array(repeating: Array(repeating: -1, count: col), count: raw)
        
        func dfs(_ ssr: Int, _ ssc: Int, _ dir: Int, _ newImage: inout [[Int]]) {
            let color = image[ssr][ssc]
            if color != oldColor {
                return
            }
            if newColor == newImage[ssr][ssc] {
                return
            }
            newImage[ssr][ssc] = newColor
            
            if dir & 0x02 != 1, ssr > 0 {
                // 上
                dfs(ssr - 1, ssc, 1, &newImage)
            }
            if dir & 0x01 != 1, ssr < raw - 1 {
                // 下
                dfs(ssr + 1, ssc, 2, &newImage)
            }
            if dir & 0x08 != 1, ssc > 0 {
                // 左
                dfs(ssr, ssc - 1, 4, &newImage)
            }
            if dir & 0x04 != 1, ssc < col - 1 {
                // 右
                dfs(ssr, ssc + 1, 8, &newImage)
            }
        }
        dfs(sr, sc, 0, &newImage)
        
        for i in 0..<raw {
            for j in 0..<col {
                if newImage[i][j] == -1 {
                    newImage[i][j] = image[i][j]
                }
            }
        }
        
        return newImage
    }
    
    
    // MARK: #695. 岛屿的最大面积
    /// #695. 岛屿的最大面积
    ///
    /// 给你一个大小为 m x n 的二进制矩阵 grid 。
    ///
    /// 岛屿 是由一些相邻的 1 (代表土地) 构成的组合，这里的「相邻」要求两个 1 必须在 水平或者竖直的四个方向上 /// 相邻。你可以假设 grid 的四个边缘都被 0（代表水）包围着。
    ///
    /// 岛屿的面积是岛上值为 1 的单元格的数目。
    ///
    /// 计算并返回 grid 中最大的岛屿面积。如果没有岛屿，则返回面积为 0 。
    ///
    /// 示例 1：
    ///
    ///     输入：grid = [
    ///     [0,0,1,0,0,0,0,1,0,0,0,0,0],
    ///     [0,0,0,0,0,0,0,1,1,1,0,0,0],
    ///     [0,1,1,0,1,0,0,0,0,0,0,0,0],
    ///     [0,1,0,0,1,1,0,0,1,0,1,0,0],
    ///     [0,1,0,0,1,1,0,0,1,1,1,0,0],
    ///     [0,0,0,0,0,0,0,0,0,0,1,0,0],
    ///     [0,0,0,0,0,0,0,1,1,1,0,0,0],
    ///     [0,0,0,0,0,0,0,1,1,0,0,0,0]]
    /// 输出：6
    /// 解释：答案不应该是 11 ，因为岛屿只能包含水平或垂直这四个方向上的 1 。
    /// 示例 2：
    ///
    ///     输入：grid = [[0,0,0,0,0,0,0,0]]
    ///     输出：0
    ///
    /// 提示：
    ///
    ///     m == grid.length
    ///     n == grid[i].length
    ///     1 <= m, n <= 50
    ///     grid[i][j] 为 0 或 1
    ///
    /// - 链接：https://leetcode-cn.com/problems/max-area-of-island
    func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
        var grid1 = grid
        let raw = grid.count, col = grid[0].count
        
        var maxArea = 0
        for i in 0..<raw {
            for j in 0..<col {
                maxArea = max(maxArea, land_dfs(&grid1, i, j, 1, -1, 0))
            }
        }
        return maxArea
    }
    
    private func land_dfs(_ land: inout [[Int]], _ sr: Int, _ sc: Int, _ target: Int, _ newValue: Int,  _ dir: Int) -> Int {
        if sr < 0 || sr > land.count - 1 {
            return 0
        }
        if sc < 0 || sc > land[0].count - 1 {
            return 0
        }
        if land[sr][sc] != target || land[sr][sc] == newValue {
            return 0
        }
        land[sr][sc] = newValue
        
        let raw = land.count, col = land[0].count
        var count = 1
        if dir & 0x02 != 1, sr > 0 {
            // 上
            count += land_dfs(&land, sr - 1, sc, target, newValue, 1)
        }
        if dir & 0x01 != 1, sr < raw - 1 {
            // 下
            count += land_dfs(&land, sr + 1, sc, target, newValue, 2)
        }
        if dir & 0x08 != 1, sc > 0 {
            // 左
            count += land_dfs(&land, sr, sc - 1, target, newValue, 4)
        }
        if dir & 0x04 != 1, sc < col - 1 {
            // 右
            count += land_dfs(&land, sr, sc + 1, target, newValue, 8)
        }
        
        return count
    }
    
    // MARK: Day 8 - 广度优先搜索 / 深度优先搜索
    
    // MARK: #617. 合并二叉树
    
    /**
     * Definition for a binary tree node.
     */
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }
    
    /// #617. 合并二叉树
    ///
    /// 给定两个二叉树，想象当你将它们中的一个覆盖到另一个上时，两个二叉树的一些节点便会重叠。
    /// 你需要将他们合并为一个新的二叉树。合并的规则是如果两个节点重叠，那么将他们的值相加作为节点合并后的新值，否则不为 NULL 的节点将直接作为新二叉树的节点。
    ///
    /// 示例 1:
    ///
    ///     输入:
    ///     Tree 1                     Tree 2
    ///           1                         2
    ///          / \                       / \
    ///         3   2                     1   3
    ///        /                           \   \
    ///       5                             4   7
    ///     输出:
    ///     合并后的树:
    ///          3
    ///         / \
    ///        4   5
    ///       / \   \
    ///      5   4   7
    ///
    /// 注意: 合并必须从两个树的根节点开始。
    ///
    /// - 链接：https://leetcode-cn.com/problems/merge-two-binary-trees
    ///
    /// - Parameters:
    ///   - root1: 二叉树 root1
    ///   - root2: 二叉树 root2
    /// - Returns: 合并 root1, root2 的新的二叉树
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil || root1 == nil {
            return nil
        }
        
        let root = TreeNode(0)
        root.val = (root1?.val ?? 0) + (root2?.val ?? 0)
        
        if root1 == nil {
            root.left = root2?.left
            root.right = root2?.right
        }
        else if root2 == nil {
            root.left = root1?.left
            root.right = root1?.right
        }
        else {
            root.left = mergeTrees(root1?.left, root2?.left)
            root.right = mergeTrees(root1?.right, root2?.right)
        }
        
        return root
    }
    
    // MARK: #116. 填充每个节点的下一个右侧节点指针
    
    /**
     * Definition for a Node.
     */
     public class Node {
         public var val: Int
         public var left: Node?
         public var right: Node?
         public var next: Node?
         public init(_ val: Int) {
             self.val = val
             self.left = nil
             self.right = nil
             self.next = nil
         }
     }
    
    /// #116. 填充每个节点的下一个右侧节点指针
    ///
    /// 给定一个 完美二叉树 ，其所有叶子节点都在同一层，每个父节点都有两个子节点。二叉树定义如下：
    ///
    ///     struct Node {
    ///       int val;
    ///       Node *left;
    ///       Node *right;
    ///       Node *next;
    ///     }
    /// 填充它的每个 next 指针，让这个指针指向其下一个右侧节点。如果找不到下一个右侧节点，则将 next 指针设置为 NULL。
    ///
    /// 初始状态下，所有 next 指针都被设置为 NULL。
    ///
    /// 进阶：
    ///
    ///     你只能使用常量级额外空间。
    ///     使用递归解题也符合要求，本题中递归程序占用的栈空间不算做额外的空间复杂度。
    ///
    /// 示例：
    ///
    ///     Tree 1                     Tree 2
    ///           1                          1 -> null
    ///         /   \                      /   \
    ///        2     3                    2  ->  3 -> null
    ///       / \   / \                 /   \  /   \
    ///      4   5 6   7               4 ->  5 6 -> 7 -> null
    ///                                       ->
    /// 输入：root = [1,2,3,4,5,6,7]
    /// 输出：[1,#,2,3,#,4,5,6,7,#]
    /// 解释：给定二叉树如图 A 所示，你的函数应该填充它的每个 next 指针，以指向其下一个右侧节点，如图 B /// 所示。序列化的输出按层序遍历排列，同一层节点由 next 指针连接，'#' 标志着每一层的结束。
    ///
    /// 提示：
    ///
    ///     树中节点的数量少于 4096
    ///     -1000 <= node.val <= 1000
    ///
    /// - 链接：https://leetcode-cn.com/problems/populating-next-right-pointers-in-each-node
    /// - Parameter root: <#root description#>
    /// - Returns: <#description#>
    func connect(_ root: Node?) -> Node? {
        let node = root
        
        func leftToRight(_ node1: Node?, _ node2: Node?) {
            if node1 == nil { return }
            
            node1?.next = node2
            leftToRight(node1?.left, node1?.right)
            leftToRight(node1?.right, node2?.left)
        }
        
        leftToRight(node, nil)
        return node
    }
    
    // MARK: Day 9 - 广度优先搜索 / 深度优先搜索
    
    // MARK: #542. 01 矩阵 (-- 2021-11-06)
    /// #542. 01 矩阵
    /// 
    /// 给定一个由 0 和 1 组成的矩阵 mat ，请输出一个大小相同的矩阵，其中每一个格子是 mat 中对应位置元素到最近的 0 的距离。
    ///
    /// 两个相邻元素间的距离为 1 。
    ///
    /// 示例 1：
    ///
    ///     [0,0,0]
    ///     [0,1,0]
    ///     [0,0,0]
    ///     输入：mat = [[0,0,0],[0,1,0],[0,0,0]]
    ///     输出：[[0,0,0],[0,1,0],[0,0,0]]
    ///
    /// 示例 2：
    ///
    ///     [0,0,0]
    ///     [0,1,0]
    ///     [1,1,1]
    ///     输入：mat = [[0,0,0],[0,1,0],[1,1,1]]
    ///     输出：[[0,0,0],[0,1,0],[1,2,1]]
    ///
    /// - 链接：https://leetcode-cn.com/problems/01-matrix
    ///
    /// - Parameter mat: <#mat description#>
    /// - Returns: <#description#>
    func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
        let raw = mat.count, col = mat[0].count
        var newMat: [[Int]] = Array(repeating: Array(repeating: -1, count: col), count: raw)
        newMat = mat
        
        for i in 0..<raw {
            for j in 0..<col {
                newMat[i][j] = matrix_dfs(&newMat, i, j, 1, 0, 0, raw + col - 1 - 1)
            }
        }
        for i in 0..<raw {
            for j in 0..<col {
                if newMat[i][j] != 0 {
                    newMat[i][j] *= -1
                }
            }
        }
        return newMat
    }
    
    private func matrix_dfs(_ land: inout[[Int]], _ sr: Int, _ sc: Int, _ target: Int, _ newValue: Int,  _ dir: Int, _ limit: Int) -> Int {
        if sr < 0 || sr > land.count - 1 {
            return 0
        }
        if sc < 0 || sc > land[0].count - 1 {
            return 0
        }
        if land[sr][sc] != target || land[sr][sc] <= newValue {
            return land[sr][sc]
        }
        
        let raw = land.count, col = land[0].count
        var count = -limit
        
        if limit <= 1 {
            return -(raw + col - 2)
        }
        
        if dir != 0x02, sr > 0 {
            // 上
            count = max(count, matrix_dfs(&land, sr - 1, sc, target, newValue, 1, -count - 1) - 1)
        }
        if dir != 0x08, sc > 0, count < -1 {
            // 左
            count = max(count, matrix_dfs(&land, sr, sc - 1, target, newValue, 4, -count - 1) - 1)
        }

        if dir != 0x01, sr < raw - 1, count < -1 {
            // 下
            count = max(count, matrix_dfs(&land, sr + 1, sc, target, newValue, 2, -count - 1) - 1)
        }
        if dir != 0x04, sc < col - 1, count < -1 {
            // 右
            count = max(count, matrix_dfs(&land, sr, sc + 1, target, newValue, 8, -count - 1) - 1)
        }
        if count == -1 {
            land[sr][sc] = count
        }
        return count
    }
    
    
    // MARK: #994. 腐烂的橘子 (-- 2021-11-09)
    /// #994. 腐烂的橘子
    ///
    /// 在给定的网格中，每个单元格可以有以下三个值之一：
    /// - 值 0 代表空单元格；
    /// - 值 1 代表新鲜橘子；
    /// - 值 2 代表腐烂的橘子。
    /// 每分钟，任何与腐烂的橘子（在 4 个正方向上）相邻的新鲜橘子都会腐烂。
    ///
    /// 返回直到单元格中没有新鲜橘子为止所必须经过的最小分钟数。如果不可能，返回 -1。
    ///
    ///     [2,1,1]     [2,2,1]     [2,2,2]     [2,2,2]     [2,2,2]
    ///     [1,1,0]     [2,1,0]     [2,2,0]     [2,2,0]     [2,2,0]
    ///     [0,1,1]     [0,1,1]     [0,1,1]     [0,2,1]     [0,2,2]
    ///                    1           2           3           4
    /// 示例 1：
    ///
    ///     输入：[[2,1,1],[1,1,0],[0,1,1]]
    ///     输出：4
    /// 示例 2：
    ///
    ///     输入：[[2,1,1],[0,1,1],[1,0,1]]
    ///     输出：-1
    ///     解释：左下角的橘子（第 2 行， 第 0 列）永远不会腐烂，因为腐烂只会发生在 4 个正向上。
    /// 示例 3：
    ///
    ///     输入：[[0,2]]
    ///     输出：0
    ///     解释：因为 0 分钟时已经没有新鲜橘子了，所以答案就是 0 。
    ///
    /// 提示：
    ///
    ///     1 <= grid.length <= 10
    ///     1 <= grid[0].length <= 10
    ///     grid[i][j] 仅为 0、1 或 2
    ///
    /// - 链接：https://leetcode-cn.com/problems/rotting-oranges
    /// - Parameter grid: grid description
    /// - Returns: 污染传递环数
    func orangesRotting(_ grid: [[Int]]) -> Int {
        
        let raw = grid.count, col = grid[0].count
        
        var newGrid = grid
        var freshCount = 0
        var rottings:Array<SIMD2<Int>> = []
        // 统计新鲜橘子个数，记录腐烂橘子的位置
        for i in 0..<raw {
            for j in 0..<col {
                if grid[i][j] == 2 {
                    let pos = SIMD2(i, j)
                    rottings.append(pos)
                }
                else if grid[i][j] == 1 {
                    freshCount += 1
                }
            }
        }
        
        var mins = 0
        // BFS
        while freshCount > 0, rottings.count > 0 {
            mins += 1
            let count = rottings.count
            for i in 0..<count {
                let pos = rottings[i]
                // 左右上下四个方位的污染
                for offsetBy in [SIMD2(0, -1), SIMD2(0, 1), SIMD2(-1, 0), SIMD2(1, 0)] {
                    let pos1 = pos &+ offsetBy
                    if pos1.x < 0 || pos1.x >= raw || pos1.y < 0 || pos1.y >= col {
                        continue
                    }
                    if newGrid[pos1.x][pos1.y] != 1 {
                        continue
                    }
                    newGrid[pos1.x][pos1.y] = 2
                    rottings.append(pos1)
                    freshCount -= 1
                }
            }
            rottings.removeFirst(count)
        }
        
        return freshCount > 0 ? -1 : mins
    }
    
    
    // MARK: Day 10 - 递归 / 回溯 (-- 2021-11-09)
    
    // MARK: #21. 合并两个有序链表
    
    // MARK: #206. 反转链表
    
    
    // MARK: Day 11 - 递归 / 回溯 (-- 2021-11-09)
    
    // MARK: #77. 组合
    /// #77. 组合
    /// 给定两个整数 n 和 k，返回范围 [1, n] 中所有可能的 k 个数的组合。
    ///
    /// 你可以按 任何顺序 返回答案。
    ///
    /// 示例 1：
    ///
    ///     输入：n = 4, k = 2
    ///     输出：
    ///     [
    ///         [2,4],
    ///         [3,4],
    ///         [2,3],
    ///         [1,2],
    ///         [1,3],
    ///         [1,4],
    ///     ]
    /// 示例 2：
    ///
    ///     输入：n = 1, k = 1
    ///     输出：[[1]]
    ///
    /// 提示：
    ///
    ///     1 <= n <= 20
    ///     1 <= k <= n
    ///
    /// - 链接：https://leetcode-cn.com/problems/combinations
    ///
    /// - Parameters:
    ///   - n: n
    ///   - k: k
    /// - Returns: 返回范围 [1, n] 中所有可能的 k 个数的组合。
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        if n < 1 || k < 1 || n < k { return [] }
        if k == 1 {
            var ans: [[Int]] = []
            for i in 1...n {
                ans.append([i])
            }
            return ans
        }
        else if k == n {
            var ans: [Int] = []
            for i in 1...n {
                ans.append(i)
            }
            return [ans]
        }
        
        var ans: [[Int]] = []
        let ans1 = combine(n - 1, k)
        let ans2 = combine(n - 1, k - 1)
        
        ans.append(contentsOf: ans1)
        for i in 0..<ans2.count {
            var an = ans2[i]
            an.append(n)
            ans.append(an)
        }
        return ans
    }
    
    // MARK: #46. 全排列
    /// #46. 全排列
    ///
    /// 给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。
    ///
    /// 示例 1：
    ///
    ///     输入：nums = [1,2,3]
    ///     输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
    /// 示例 2：
    ///
    ///     输入：nums = [0,1]
    ///     输出：[[0,1],[1,0]]
    /// 示例 3：
    ///
    ///     输入：nums = [1]
    ///     输出：[[1]]
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 6
    ///     -10 <= nums[i] <= 10
    ///     nums 中的所有整数 互不相同
    ///
    /// - 链接：https://leetcode-cn.com/problems/permutations
    ///     
    /// 执行结果：通过
    ///
    ///     执行用时：8 ms, 在所有 Swift 提交中击败了98.87%的用户
    ///     内存消耗：13.3 MB, 在所有 Swift 提交中击败了98.87%的用户
    ///     通过测试用例：26 / 26
    /// - Parameter nums: 一个不含重复数字的数组 nums
    /// - Returns: 返回其所有可能的全排列
    func permute(_ nums: [Int]) -> [[Int]] {
        var newNums: [[Int]] = []
        var permuteNums: [Int] = []
        var tmp = nums
        permute_dfs(&newNums, &permuteNums, &tmp)
        return newNums
    }
    
    func permute_dfs(_ permutes: inout [[Int]], _ permute: inout [Int], _ temp: inout [Int]) {
        if temp.count == 0 {
            permutes.append(permute)
            return
        }
        
        for i in 0..<temp.count {
            let first = temp.removeFirst()
//            let first = temp.remove(at: i)
            
            permute.append(first)
            permute_dfs(&permutes, &permute, &temp)
            permute.removeLast()
            
            temp.append(first)
//            temp.insert(first, at: i)
        }
    }
    
    // MARK: #784. 字母大小写全排列 (-- 2021-11-10)
    /// #784. 字母大小写全排列
    ///
    /// 给定一个字符串S，通过将字符串S中的每个字母转变大小写，我们可以获得一个新的字符串。返回所有可能得到的字符串集合。
    ///
    /// 示例：
    ///
    ///     输入：S = "a1b2"
    ///     输出：["a1b2", "a1B2", "A1b2", "A1B2"]
    ///
    ///     输入：S = "3z4"
    ///     输出：["3z4", "3Z4"]
    ///
    ///     输入：S = "12345"
    ///     输出：["12345"]
    ///
    /// 提示：
    ///
    ///     S 的长度不超过12。
    ///     S 仅由数字和字母组成。
    ///
    /// - 链接：https://leetcode-cn.com/problems/letter-case-permutation
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：76 ms, 在所有 Swift 提交中击败了72.22%的用户
    ///     内存消耗：14.2 MB, 在所有 Swift 提交中击败了88.89%的用户
    ///     通过测试用例：63 / 63
    /// - Parameter s: S 仅由数字和字母组成
    /// - Returns: 字符串S中的每个字母转变大小写可以获得一个新的字符串。返回所有可能得到的字符串集合。
    func letterCasePermutation(_ s: String) -> [String] {
        var collections: [String] = []
        var letters = ""
        letterCasePermutation_dfs(&collections, &letters, s: s, length: s.count)
        return collections
    }
    
    func letterCasePermutation_dfs( _ collections: inout [String], _ letters: inout String, s: String, length: Int) {
        if letters.count == length {
            collections.append(letters)
            return
        }
        
        let ch = s[letters.endIndex]
            
        letters.append(ch.lowercased())
            letterCasePermutation_dfs(&collections, &letters, s: s, length: length)
            letters.removeLast()
            
            if ch >= "0", ch <= "9" {
                return
            }
            
            letters.append(ch.uppercased())
            letterCasePermutation_dfs(&collections, &letters, s: s, length: length)
            letters.removeLast()
    }
    
    // MARK: 第 12 天 - 动态规划
    
    // MARK: #70. 爬楼梯
    /// #
    ///
    ///
    
    // MARK: #198. 打家劫舍
    /// #198. 打家劫舍
    ///
    /// 你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
    ///
    /// 给定一个代表每个房屋存放金额的非负整数数组，计算你 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。
    ///
    /// 示例 1：
    ///
    ///     输入：[1,2,3,1]
    ///     输出：4
    ///     解释：偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
    ///     偷窃到的最高金额 = 1 + 3 = 4 。
    /// 示例 2：
    ///
    ///     输入：[2,7,9,3,1]
    ///     输出：12
    ///     解释：偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
    ///      偷窃到的最高金额 = 2 + 9 + 1 = 12 。
    ///
    /// 提示：
    ///
    ///     1 <= nums.length <= 100
    ///     0 <= nums[i] <= 400
    ///
    /// - 链接：https://leetcode-cn.com/problems/house-robber
    ///
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func rob(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        if nums.count == 1 { return nums[0] }
        
        var money0 = nums[0]
        var money1 = nums[1]
        
        for i in 2..<nums.count {
            let temp = max(money0 + nums[i], money1, money1 - nums[i-1] + nums[i])
            money0 = money1
            money1 = temp
        }
        
        return max(money0, money1)
    }
    
    // MARK: #120. 三角形最小路径和
    /// #120. 三角形最小路径和
    ///
    /// 给定一个三角形 triangle ，找出自顶向下的最小路径和。
    ///
    /// 每一步只能移动到下一行中相邻的结点上。相邻的结点 在这里指的是 下标 与 上一层结点下标 相同或者等于 上一层结点下标 + 1 的两个结点。也就是说，如果正位于当前行的下标 i ，那么下一步可以移动到下一行的下标 i 或 i + 1 。
    ///
    /// 示例 1：
    ///
    ///     输入：triangle = [[2],[3,4],[6,5,7],[4,1,8,3]]
    ///     输出：11
    ///     解释：如下面简图所示：
    ///        2
    ///       3 4
    ///      6 5 7
    ///     4 1 8 3
    ///     自顶向下的最小路径和为 11（即，2 + 3 + 5 + 1 = 11）。
    /// 示例 2：
    ///
    ///     输入：triangle = [[-10]]
    ///     输出：-10
    ///
    /// 提示：
    ///
    ///     1 <= triangle.length <= 200
    ///     triangle[0].length == 1
    ///     triangle[i].length == triangle[i - 1].length + 1
    ///     -10^4 <= triangle[i][j] <= 10^4
    ///
    /// 进阶：
    ///
    ///     你可以只使用 O(n) 的额外空间（n 为三角形的总行数）来解决这个问题吗？
    ///
    ///  - 链接：https://leetcode-cn.com/problems/triangle
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：36 ms, 在所有 Swift 提交中击败了71.95%的用户
    ///     内存消耗：13.7 MB, 在所有 Swift 提交中击败了87.81%的用户
    ///     通过测试用例：44 / 44
    ///
    /// - Parameter triangle: <#triangle description#>
    /// - Returns: <#description#>
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        if triangle.count == 0 { return 0 }
        if triangle.count == 1 { return triangle[0][0] }
        
        var total: [Int] = Array(repeating: 99999, count: triangle.count)
        total[0] = triangle[0][0]
        for i in 1..<total.count {
            let row = triangle[i]
            var temp = total[0]
            for j in 0..<row.count {
                let value = row[j]
                if j == 0 {
                    total[0] = temp + value
                }
                else {
                    let temp1 = total[j]
                    total[j] = min(temp, total[j]) + value
                    temp = temp1
                }
            }
        }
        
        var minimum = total[0]
        for value in total {
            if minimum > value {
                minimum = value
            }
        }
        return minimum
    }
    
    
    // MARK: 第 13 天 - 位运算
    
    // MARK: #231. 2 的幂
    /// #231. 2 的幂
    ///
    /// 给你一个整数 n，请你判断该整数是否是 2 的幂次方。如果是，返回 true ；否则，返回 false 。
    ///
    /// 如果存在一个整数 x 使得 n == 2^x ，则认为 n 是 2 的幂次方。
    ///
    /// 示例 1：
    ///
    ///     输入：n = 1
    ///     输出：true
    ///     解释：20 = 1
    /// 示例 2：
    ///
    ///     输入：n = 16
    ///     输出：true
    ///     解释：24 = 16
    /// 示例 3：
    ///
    ///     输入：n = 3
    ///     输出：false
    /// 示例 4：
    ///
    ///     输入：n = 4
    ///     输出：true
    /// 示例 5：
    ///
    ///     输入：n = 5
    ///     输出：false
    ///
    /// 提示：
    ///
    /// -2^31 <= n <= 2^31 - 1
    ///
    /// - 链接：https://leetcode-cn.com/problems/power-of-two
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：4 ms, 在所有 Swift 提交中击败了85.19%的用户
    ///     内存消耗：13.4 MB, 在所有 Swift 提交中击败了64.20%的用户
    ///     通过测试用例：1108 / 1108
    /// - Parameter n: 整数 n
    /// - Returns: 如果是该整数是否是 2 的幂次方，返回 true ；否则，返回 false 。
    func isPowerOfTwo(_ n: Int) -> Bool {
        if n <= 0 { return false }
        if n == 1 { return true }
        
        var n1 = n
        while n1 != 0 , n1 != 1 , n1 != -1 {
            let bit = n1 & 0x01
            if bit == 1 {
                return false
            }
            n1 >>= 1
        }
        
        // 循环部分亦可使用递归
        /*
        if n & 0x01 == 1 { return false }
        isPowerOfTwo(n/2)
        */
        return true
    }
    
    // MARK: #191. 位1的个数
    /// #191. 位1的个数
    ///
    /// 编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数（也被称为汉明重量）。
    ///
    /// 提示：
    ///
    ///     请注意，在某些语言（如 Java）中，没有无符号整数类型。在这种情况下，输入和输出都将被指定为有符号整数类型，并且不应影响您的实现，因为无论整数是有符号的还是无符号的，其内部的二进制表示形式都是相同的。
    ///     在 Java 中，编译器使用二进制补码记法来表示有符号整数。因此，在上面的 示例 3 中，输入表示有符号整数 -3。
    ///
    /// 示例 1：
    ///
    ///     输入：00000000000000000000000000001011
    ///     输出：3
    ///     解释：输入的二进制串 00000000000000000000000000001011 中，共有三位为 '1'。
    /// 示例 2：
    ///
    ///     输入：00000000000000000000000010000000
    ///     输出：1
    ///     解释：输入的二进制串 00000000000000000000000010000000 中，共有一位为 '1'。
    /// 示例 3：
    ///
    ///     输入：11111111111111111111111111111101
    ///     输出：31
    ///     解释：输入的二进制串 11111111111111111111111111111101 中，共有 31 位为 '1'。
    ///
    /// 提示：
    ///
    ///     输入必须是长度为 32 的 二进制串 。
    ///
    /// 进阶：
    ///
    ///     如果多次调用这个函数，你将如何优化你的算法？
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：0 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：12.7 MB, 在所有 Swift 提交中击败了93.06%的用户
    ///     通过测试用例：601 / 601
    ///
    /// - 链接：https://leetcode-cn.com/problems/number-of-1-bits
    func hammingWeight(_ n: Int) -> Int {
        if n == 0 { return 0 }
        
        var n1 = n
        var weight = 0
        while n1 != 0 {
            let bit = n1 & 0x01
            if bit == 1 {
                weight += 1
            }
            n1 >>= 1
        }
        
        /** n & (n−1)，其运算结果恰为把 n 的二进制位中的最低位的 1 变为 0 之后的结果。
         * 利用这个位运算的性质加速我们的检查过程，在实际代码中，我们不断让当前的 n 与 n−1 做与运算，直到 n 变为 0 即可。因为每次运算会使得 n 的最低位的 1 被翻转，因此运算次数就等于 n 的二进制位中 1 的个数。
         */
//        while n1 != 0 {
//            n1 &= n1 - 1
//            weight += 1
//        }
        return weight
    }
    
    // MARK: 第 14 天 - 位运算
    
    // MARK: #190. 颠倒二进制位
    /// #190. 颠倒二进制位
    ///
    /// 颠倒给定的 32 位无符号整数的二进制位。
    ///
    /// 提示：
    ///
    ///     - 请注意，在某些语言（如 Java）中，没有无符号整数类型。在这种情况下，输入和输出都将被指定为有符号整数类型，并且不应影响您的实现，因为无论整数是有符号的还是无符号的，其内部的二进制表示形式都是相同的。
    ///     - 在 Java 中，编译器使用二进制补码记法来表示有符号整数。因此，在 示例 2 中，输入表示有符号整数 -3，输出表示有符号整数 -1073741825。
    ///
    /// 示例 1：
    ///
    ///     输入：n = 00000010100101000001111010011100
    ///     输出：964176192 (00111001011110000010100101000000)
    ///     解释：输入的二进制串 00000010100101000001111010011100 表示无符号整数 43261596，
    ///     因此返回 964176192，其二进制表示形式为 00111001011110000010100101000000。
    /// 示例 2：
    ///
    ///     输入：n = 11111111111111111111111111111101
    ///     输出：3221225471 (10111111111111111111111111111111)
    ///     解释：输入的二进制串 11111111111111111111111111111101 表示无符号整数 4294967293，
    ///     因此返回 3221225471 其二进制表示形式为 10111111111111111111111111111111 。
    ///
    /// 提示：
    ///
    ///     输入是一个长度为 32 的二进制字符串
    ///
    /// 进阶: 如果多次调用这个函数，你将如何优化你的算法？
    ///
    /// - 链接：https://leetcode-cn.com/problems/reverse-bits
    ///
    /// 执行结果：通过
    ///
    ///     执行用时：0 ms, 在所有 Swift 提交中击败了100.00%的用户
    ///     内存消耗：13.4 MB, 在所有 Swift 提交中击败了75.68%的用户
    ///     通过测试用例：600 / 600
    ///
    /// - Parameter n: 32 位无符号整数
    /// - Returns: 颠倒给定的整数的二进制位，返回新数值
    func reverseBits(_ n: Int) -> Int {
        var n1 = 0
        for i in 0..<32 {
            n1 = (n1 << 1) + ((n >> i) & 0x1)
        }
        /** 分治法
         * 12345678 => 21436587 => 43218765 => 87654321
         */
        return n1
    }
    
    // MARK: #136. 只出现一次的数字
    /// #136. 只出现一次的数字
    /// 
    /// 给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
    ///
    /// 说明：
    ///
    ///     你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
    ///
    /// 示例 1:
    ///
    ///     输入: [2,2,1]
    ///     输出: 1
    /// 示例 2:
    ///
    ///     输入: [4,1,2,1,2]
    ///     输出: 4
    ///
    ///  - 链接：https://leetcode-cn.com/problems/single-number
    ///
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func singleNumber(_ nums: [Int]) -> Int {
        // 重复元素出现两次，一加一减即为零。可适用异或
        /**
         执行用时：120 ms, 在所有 Swift 提交中击败了81.35%的用户
         内存消耗：14.3 MB在所有 Swift 提交中击败了44.86%的用户
         通过测试用例：61 / 61
         */
        var res = 0
        for value in nums {
            res ^= value
        }
        return res
        
        /** 数组
         */
//        var temp: [Int] = []
//        for value in nums {
//            if let index = temp.firstIndex(of: value) {
//                temp.remove(at: index)
//            } else {
//                temp.append(value)
//            }
//        }
//        return temp.first!
        
        /** 哈希表
         执行用时：128 ms, 在所有 Swift 提交中击败了35.41%的用户
         内存消耗：14.5 MB, 在所有 Swift 提交中击败了5.13%的用户
         通过测试用例：61 / 61
         */
//        var temp: [Int: Int] = [:]
//        for value in nums {
//            if let v = temp[value] {
//                temp.removeValue(forKey: v)
//            } else {
//                temp[value] = value
//            }
//        }
//        return temp.keys.first!
        
    }
}

