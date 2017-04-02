Return-path: <julia.lawall@lip6.fr>
Date: Sun, 2 Apr 2017 13:09:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
    linux@roeck-us.net, wim@iguana.be, sathyaosid@gmail.com,
    david.e.box@linux.intel.com, rajneesh.bhardwaj@intel.com,
    sathyanarayanan.kuppuswamy@linux.intel.com,
    platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-watchdog@vger.kernel.org, kbuild-all@01.org
Subject: Re: [PATCH v4 2/5] platform/x86: intel_pmc_ipc: Add pmc gcr
 read/write/update api's (fwd)
Message-ID: <alpine.DEB.2.20.1704021307570.2353@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-watchdog@vger.kernel.org>

tmp has type u32 and thus will not be < 0

julia

---------- Forwarded message ----------
Date: Sun, 2 Apr 2017 14:26:03 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v4 2/5] platform/x86: intel_pmc_ipc: Add pmc gcr
    read/write/update api's

In-Reply-To: <1ca7187132bd2b98ca87d0829a3c76022f041924.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>

Hi Kuppuswamy,

[auto build test WARNING on platform-drivers-x86/for-next]
[also build test WARNING on v4.11-rc4 next-20170331]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kuppuswamy-Sathyanarayanan/platform-x86-intel_pmc_ipc-fix-gcr-offset/20170402-113300
base:   git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git for-next
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/platform/x86/intel_pmc_ipc.c:277:5-8: WARNING: Unsigned expression compared with zero: tmp < 0

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout f98055b2d8ad767578e0fafd280274a6cd499459
vim +277 drivers/platform/x86/intel_pmc_ipc.c

f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  261  /**
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  262   * intel_pmc_gcr_update() - Update PMC GCR register bits
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  263   * @offset:	offset of GCR register from GCR address base
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  264   * @mask:	bit mask for update operation
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  265   * @val:	update value
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  266   *
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  267   * Updates the bits of given GCR register as specified by
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  268   * mask and val
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  269   *
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  270   * Return:	negative value on error or 0 on success.
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  271   */
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  272  int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  273  {
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  274  	u32 orig, tmp;
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  275
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  276  	tmp = is_gcr_valid(offset);
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31 @277  	if (tmp < 0)
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  278  		return tmp;
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  279
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  280  	orig = readl(ipcdev.gcr_mem_base + offset);
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  281
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  282  	tmp = orig & ~mask;
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  283  	tmp |= val & mask;
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  284
f98055b2 Kuppuswamy Sathyanarayanan 2017-03-31  285  	writel(tmp, ipcdev.gcr_mem_base + offset);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
