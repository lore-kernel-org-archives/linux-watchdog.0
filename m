Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06F2F8EAE;
	Wed, 20 May 2026 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253911; cv=none; b=Kb3z1JSkj//UgPpcwmRc1nfjbsHybX0Ex5+g4U3S5+5AbmKuX1j9C12daxp5+7a5TMDoq3KTNSb4YARocVnCRdrncphS6hjoT4JTe44USWV85O+AztfdFvp9BgamMr/gH/0mio5xY9RecfhiwreFZBzlPcdFA9rq1f2nx0IXoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253911; c=relaxed/simple;
	bh=dYqJGHd/M/vWTTidWc0sD1R4Tee/pwkCRdXdlBEi2RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCzQEDfHO4Y1wPPviUzyPRv4MIIwLByP/phc2SKW/n2OjfLxAIEJChePAlt+3epb+n/2O2nGlA2KeFZVHQMzT39W/seEX6XStMpMMsS16C4Lio9zPh6f8Nwlymz2WXA4u7jX/HO0u6dZAIClbzRy0Og+k5m45BM8KyphdjGyDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCIE1WXT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCIE1WXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779253909; x=1810789909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYqJGHd/M/vWTTidWc0sD1R4Tee/pwkCRdXdlBEi2RE=;
  b=hCIE1WXThoGvPiNR8QTxTnH4AqvFD3dVdTboxf8Qk6jF6CtHKsW/a+83
   bDpDlnNF/fggmFza3VWje1jyZbZhqjNjCmsy+t4NezwtZAdlU5h1CoNc6
   JiceNdHqcFHVMJPuWWVIKUXTbQrM7K7wkftky/IeFVgee7zTunZ1coViH
   8C6v22vUTGr8ioJDeUBIHmMgDlYPU36iafopfvgSOMFPsLxfYjMATQebg
   APBeyh0IDIPy4RkpqY4irQWXmaXPxkQQEB+UZHN6uRFCF+YYoVNspUvHK
   6nEruYs0jHI5PCMKjHXi8Wy+LLKbJ75ScVv7962IEYuCTLfRdfJmOI1DF
   A==;
X-CSE-ConnectionGUID: GKuVTdwiSkuv2bFPkzS4Xw==
X-CSE-MsgGUID: MXJDpPGkQQaRfVsfHoi+pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79992584"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79992584"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 22:11:48 -0700
X-CSE-ConnectionGUID: vqc7lRqzShuGVTCK+Y27hQ==
X-CSE-MsgGUID: nAH6ab3YTSe0TraKMbYM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239026230"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 19 May 2026 22:11:46 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPZDE-000000002V3-2l6D;
	Wed, 20 May 2026 05:11:30 +0000
Date: Wed, 20 May 2026 13:10:15 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and
 watchdog management
Message-ID: <202605201246.gIDxpcj6-lkp@intel.com>
References: <20260519214229.16656-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519214229.16656-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon]
[also build test WARNING on groeck-staging/hwmon-next groeck-staging/watchdog groeck-staging/watchdog-next linus/master v7.1-rc4 next-20260519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/watchdog-orion_wdt-Use-devm-APIs-for-clock-and-watchdog-management/20260520-054408
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon
patch link:    https://lore.kernel.org/r/20260519214229.16656-1-rosenp%40gmail.com
patch subject: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and watchdog management
config: arm-dove_defconfig (https://download.01.org/0day-ci/archive/20260520/202605201246.gIDxpcj6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605201246.gIDxpcj6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605201246.gIDxpcj6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/watchdog/orion_wdt.c: In function 'orion_wdt_clock_init':
>> drivers/watchdog/orion_wdt.c:82:13: warning: unused variable 'ret' [-Wunused-variable]
      82 |         int ret;
         |             ^~~
   drivers/watchdog/orion_wdt.c: In function 'armada370_wdt_clock_init':
   drivers/watchdog/orion_wdt.c:95:13: warning: unused variable 'ret' [-Wunused-variable]
      95 |         int ret;
         |             ^~~
   drivers/watchdog/orion_wdt.c: In function 'armada375_wdt_clock_init':
   drivers/watchdog/orion_wdt.c:113:13: warning: unused variable 'ret' [-Wunused-variable]
     113 |         int ret;
         |             ^~~
   drivers/watchdog/orion_wdt.c: In function 'armadaxp_wdt_clock_init':
   drivers/watchdog/orion_wdt.c:144:13: warning: unused variable 'ret' [-Wunused-variable]
     144 |         int ret;
         |             ^~~


vim +/ret +82 drivers/watchdog/orion_wdt.c

22ac92322c83334 drivers/watchdog/orion5x_wdt.c Sylver Bruneau  2008-06-26  78  
1924227bcda1d18 drivers/watchdog/orion_wdt.c   Ezequiel Garcia 2014-02-10  79  static int orion_wdt_clock_init(struct platform_device *pdev,
1924227bcda1d18 drivers/watchdog/orion_wdt.c   Ezequiel Garcia 2014-02-10  80  				struct orion_watchdog *dev)
df6707b21904950 drivers/watchdog/orion5x_wdt.c Thomas Reitmayr 2009-02-20  81  {
1924227bcda1d18 drivers/watchdog/orion_wdt.c   Ezequiel Garcia 2014-02-10 @82  	int ret;
df6707b21904950 drivers/watchdog/orion5x_wdt.c Thomas Reitmayr 2009-02-20  83  
df5a672cef35a9e drivers/watchdog/orion_wdt.c   Rosen Penev     2026-05-19  84  	dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
1924227bcda1d18 drivers/watchdog/orion_wdt.c   Ezequiel Garcia 2014-02-10  85  	if (IS_ERR(dev->clk))
1924227bcda1d18 drivers/watchdog/orion_wdt.c   Ezequiel Garcia 2014-02-10  86  		return PTR_ERR(dev->clk);
df6707b21904950 drivers/watchdog/orion5x_wdt.c Thomas Reitmayr 2009-02-20  87  
463f96e0cdacce5 drivers/watchdog/orion_wdt.c   Ezequiel Garcia 2014-02-10  88  	dev->clk_rate = clk_get_rate(dev->clk);
0dd6e4847ed8a42 drivers/watchdog/orion_wdt.c   Axel Lin        2012-03-26  89  	return 0;
df6707b21904950 drivers/watchdog/orion5x_wdt.c Thomas Reitmayr 2009-02-20  90  }
df6707b21904950 drivers/watchdog/orion5x_wdt.c Thomas Reitmayr 2009-02-20  91  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
