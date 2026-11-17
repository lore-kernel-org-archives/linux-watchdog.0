Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930754;
	b=nLveTeUc4Z55rd5uefdFamPYrmAzGVEXtQcXbU2SDHp8nLp7AYfwBTqPz+n4eatWn88W
	 RbBshZgSvn86dbbbkIC9yXro6ux5Gts38VDWuM9XelEC5QWS5am9FxIHAjh8SNgk5Mdqs
	 m68luftybZYLNy/HF8fjhYNFRSokcOpICNWPgWe7DeXn9OZ116WITSn9+ZIVIwqrMjcR0
	 lTiSTR0LUdw1DDVZm5TMcWICX1Qq3V9HkJRFN1ldCzIugAPC2HoDf6oofnSOMplOYuoz/
	 v8plG0PlSmFieukMhWewTjXZonmAqkPTAozTGYgS3N3XsXIKWsOb7YuFcyzVkJNoQEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930754;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=uO1DEpX/Sdk0AbUa13aZ6W/TOYUzfkDuzHxFvUxx8t4=;
	b=iwIffb2nLbD+NNMC5dvSAF2j8QjY+chJXfFfy2/N6+uE3/trWfO9ccYtsoiaACoaZLbM
	 yHc31CIZuzIyT2sypzL7p1EGuHvlRlWKC2Yk8NAvPJmT2kxdijcGNP4Hpvg7TpjQ/A3G5
	 Qd1TOCcWDqyT5md0AOCPZK38BiZBpeuysBL9bz7OZD6Os1yGG8snprLVyL/9v633kfsbz
	 OIrRRH6zFMF+b15d/njLmw30N2cXEbatNZ8FCyXGwHYYsCrVaSruTvQhlcoUz7K2D763i
	 O38P+lUm7etXl/7bwQFbn6qMAwIma6Kl5ltcowyjIwjGvTLqliPSjqWrup7ZFU4yYog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HH+m7oiu;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FE606A32F;
	Tue, 17 Nov 2026 15:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A00FE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HH+m7oiu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794930752; x=1826466752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3CdFWivnZIGgdKSr6ahNFtljVOdDNHvNk1RCwFrBiFU=;
  b=HH+m7oiuJejRG7yUCyxsD99zqTxqSwKbeG6nB6Qo294C5nLw99lqQ1cF
   t+ar+d7MGRwoRiy20TCfHCpEdsobsKvOeqEPFDBLOrP2OWgO83Hku89Qr
   jrC5INyZlfa/dRb6AachYTSZGl/21rAOth3bZB6IirkNa5IKwuYRB4Dst
   9J0nzh7uAujZuS3fmQ1x4B6tgmhBFdYSDYp1BjmmHKbCIbnWULU3tJ/HB
   V9OTFDbHl4HyIS1M/C9drS1Enwc/sebNwRO9ar9WrDH8MUJfaGRNQbqEQ
   hDOdW3E5vI1efNns6Z5l19NWWcOIAr3emFViPR9vNjZMQtgNeUq9QGzIe
   Q==;
X-CSE-ConnectionGUID: CmtoYTZMSgmt5atv+rD/Zg==
X-CSE-MsgGUID: HF4rw1F8Qi6DGRYPvWXNOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3742664"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3742664"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:52:32 -0800
X-CSE-ConnectionGUID: toWrsmohT4m0OWvmH/CRZA==
X-CSE-MsgGUID: sMFT57sMSEOce1NigVoc/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10189662"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2026 07:52:30 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTLTu-00000001Bwf-2maE;
	Tue, 17 Nov 2026 15:52:26 +0000
Date: Tue, 17 Nov 2026 23:51:48 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Siyuan <hsyysy@163.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sunxi_wdt: stop the watchdog across system
 suspend
Message-ID: <202611172344.RbQl66xu-lkp@intel.com>
References: <20261117092036.12192-1-hsyysy@163.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117092036.12192-1-hsyysy@163.com>

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aebb7274476403040d582c61478df8f4a7bf9cd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Siyuan/watchdog-sunxi_wdt-stop-the-watchdog-across-system-suspend/20261117-172036
base:   aebb7274476403040d582c61478df8f4a7bf9cd3
patch link:    https://lore.kernel.org/r/20261117092036.12192-1-hsyysy%40163.com
patch subject: [PATCH] watchdog: sunxi_wdt: stop the watchdog across system suspend
config: csky-randconfig-1001-20261117 (https://download.01.org/0day-ci/archive/20261117/202611172344.RbQl66xu-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611172344.RbQl66xu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611172344.RbQl66xu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/sunxi_wdt.c:245:12: warning: 'sunxi_wdt_resume' defined but not used [-Wunused-function]
     245 | static int sunxi_wdt_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~
>> drivers/watchdog/sunxi_wdt.c:235:12: warning: 'sunxi_wdt_suspend' defined but not used [-Wunused-function]
     235 | static int sunxi_wdt_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~


vim +/sunxi_wdt_resume +245 drivers/watchdog/sunxi_wdt.c

   228	
   229	/*
   230	 * The hardware watchdog has a maximum timeout of 16 seconds.  A system
   231	 * suspend easily lasts longer than that, and the watchdog core only cancels
   232	 * its ping worker during suspend; it does not stop the timer.  Stop the
   233	 * watchdog explicitly while suspended and re-arm it on resume.
   234	 */
 > 235	static int sunxi_wdt_suspend(struct device *dev)
   236	{
   237		struct sunxi_wdt_dev *sunxi_wdt = dev_get_drvdata(dev);
   238	
   239		sunxi_wdt->running_at_suspend = sunxi_wdt_is_running(&sunxi_wdt->wdt_dev);
   240		sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
   241	
   242		return 0;
   243	}
   244	
 > 245	static int sunxi_wdt_resume(struct device *dev)
   246	{
   247		struct sunxi_wdt_dev *sunxi_wdt = dev_get_drvdata(dev);
   248	
   249		if (sunxi_wdt->running_at_suspend)
   250			sunxi_wdt_start(&sunxi_wdt->wdt_dev);
   251	
   252		return 0;
   253	}
   254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
