Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C34508E9;
	Wed,  7 Oct 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392764; cv=none; b=omeFClcz549vsVeq6yWs6leEoiCCeW5mejKRMO+x2rs2lDTpOfHjxGWWBHog8r7KyyyXk1QQSSRD6CEL5ECX7orin90EBTQM3hRHCqKLy4Fr8upzNc3SC/rfMQHG6VrLlVZg294XkMxKBvXCG2Vxh5jcZ4g7wzyaz6tLgl9Qu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392764; c=relaxed/simple;
	bh=4Di9jjkPZRbMXw5Y+FPdrZy1q8BfQ5HHO2Ka6Cnkppc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/XIVeUiYPI0wAYWuSwL2dvqmqOuo88b50Zk/Bn4RcAdZBMIAK5gSplueLCQun+x/q3oQufmdi6108Jgdsu1jUkBXMmrUQ6RBpnPPuVrxTHtJnUSfv4z7+zYpsaoR6lRQEffTmITZOF/mDYqSNpUEfwwGKoSkYpehrsENKPtIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKJHJ7lP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKJHJ7lP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791392763; x=1822928763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Di9jjkPZRbMXw5Y+FPdrZy1q8BfQ5HHO2Ka6Cnkppc=;
  b=MKJHJ7lPrZxmxyEIi2X8m8/PHZozYJyD07+WaImHwiFQ5uKxkLDhAnmt
   t1jwMATQ0a1bkvPoyDemC366MAhnBUOe1fA4FjFoeZ/DQlHw5HhkSn9Dv
   MDiwr+z+rjFEfyn3ucYDRBQ5G1nngsobs11t7j22Xf0LHh/r1VTgg/GWB
   evJWuQK6wWRFx/tTpGvywKsCgnXJURzVAB6U9RRmYaKuHoCDE46pF0JVH
   vW2Z7Bjv8ETP+yJ+acUL9N7h+F3nQxCIHBWDRcRwBUOg4KtqQpE4JJ1/A
   C9w1/ZEckGediF38gj1c4RK2hMhsEnGgnqvkde4/03OrKpj4zBKoHWOmv
   A==;
X-CSE-ConnectionGUID: wnkFUWfBRACojXU4SQ9ICg==
X-CSE-MsgGUID: fJe0qbF7Qxu07+T7kgUYgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="56743"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="56743"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 10:06:02 -0700
X-CSE-ConnectionGUID: 5jV75Z5vRG2tKVZEXSO0pw==
X-CSE-MsgGUID: JgUFJd3SRo21SJwbUmfugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="96303"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Oct 2026 10:06:00 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEV5a-000000003Js-0TZ1;
	Wed, 07 Oct 2026 17:05:58 +0000
Date: Thu, 8 Oct 2026 01:05:27 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Louvel <paul.louvel@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Louvel <paul.louvel@bootlin.com>
Subject: Re: [PATCH v3 2/6] watchdog: w83627hf_wdt: Convert to platform
 driver model
Message-ID: <202610080027.3OsJDwfo-lkp@intel.com>
References: <20261004-w83627hf_wdt-improvements-v3-2-8e27b518595e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-2-8e27b518595e@bootlin.com>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 028ef9c96e96197026887c0f092424679298aae8]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Louvel/watchdog-w83627hf_wdt-Replace-magic-numbers-with-descriptive-macros/20261004-141249
base:   028ef9c96e96197026887c0f092424679298aae8
patch link:    https://lore.kernel.org/r/20261004-w83627hf_wdt-improvements-v3-2-8e27b518595e%40bootlin.com
patch subject: [PATCH v3 2/6] watchdog: w83627hf_wdt: Convert to platform driver model
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20261008/202610080027.3OsJDwfo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610080027.3OsJDwfo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610080027.3OsJDwfo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/watchdog/w83627hf_wdt.c: In function 'wdt_probe':
>> drivers/watchdog/w83627hf_wdt.c:483:30: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     483 |                  "%s Watchdog", id->name);
         |                              ^
   drivers/watchdog/w83627hf_wdt.c:482:9: note: 'snprintf' output between 10 and 33 bytes into a destination of size 32
     482 |         snprintf(data->info.identity, sizeof(data->info.identity),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     483 |                  "%s Watchdog", id->name);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +483 drivers/watchdog/w83627hf_wdt.c

   460	
   461	static int wdt_probe(struct platform_device *pdev)
   462	{
   463		const struct platform_device_id *id = platform_get_device_id(pdev);
   464		struct device *dev = &pdev->dev;
   465		struct watchdog_device *wdd;
   466		struct w83627hf_data *data;
   467		enum chips chip;
   468		int ret;
   469	
   470		dev_info(dev, "WDT driver initialising\n");
   471	
   472		if (!id)
   473			return dev_err_probe(dev, -EINVAL, "failed to get chip id\n");
   474	
   475		chip = id->driver_data;
   476	
   477		data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
   478		if (!data)
   479			return -ENOMEM;
   480	
   481		data->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
   482		snprintf(data->info.identity, sizeof(data->info.identity),
 > 483			 "%s Watchdog", id->name);
   484	
   485		wdd = &data->wdd;
   486	
   487		wdd->parent = dev;
   488		wdd->info = &data->info;
   489		wdd->ops = &wdt_ops;
   490		wdd->timeout = WATCHDOG_TIMEOUT;
   491		wdd->min_timeout = 1;
   492		wdd->max_timeout = 255;
   493	
   494		watchdog_set_drvdata(wdd, data);
   495		watchdog_init_timeout(wdd, timeout, NULL);
   496		watchdog_set_nowayout(wdd, nowayout);
   497		watchdog_stop_on_reboot(wdd);
   498	
   499		ret = w83627hf_init(wdd, chip);
   500		if (ret)
   501			return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
   502	
   503		ret = devm_watchdog_register_device(dev, wdd);
   504		if (ret)
   505			return ret;
   506	
   507		dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
   508			 wdd->timeout, nowayout);
   509	
   510		return ret;
   511	}
   512	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
