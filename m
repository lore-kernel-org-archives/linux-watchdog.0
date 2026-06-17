Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C22BE65F;
	Wed, 17 Jun 2026 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781670683; cv=none; b=tLeD8VU/6nofLiHgvxOvPySQUS/gqr6/gQzc+ls7oL+6cKvlzgl3FPi1LKH+wrNaQyBR3a7yRyaGjTunRyOSImqHTtFZZSifRc2HU1v1ljIbTPoQNgr2IoXiuqxXTXKsZndLUkHnqGSyJVVbPEpwycTSYe8JRjIfHOWtW1y463A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781670683; c=relaxed/simple;
	bh=fuBYLsIG7SQZqW0+EfSTHAPNF+hrksGBtuTJ6CVfeBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MchWOMVewOCC+byV2MyT266eQyemlbaLVuLiuGyH0YcaWrIniVhDrwAQeaaWSs+ehg1rAvEHv/pYGIDzume1EnRlthxaVs7NWNs5kMPYYM+C49RvVCOZPoPFKC1QI5jkGEyPoV9qNvNm+dAbDOhdx0PZpTZuvYlPGpYzhkG6EoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxM0nmQe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxM0nmQe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781670682; x=1813206682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fuBYLsIG7SQZqW0+EfSTHAPNF+hrksGBtuTJ6CVfeBk=;
  b=FxM0nmQe6raQMul6zP25gpVi6Sz0vqUHBRZPsvbkYmnpL2YRskgbRf4d
   F11jr/PC8b2kI7eJAo30yD/a1vke/4c/XtaaEJIsCSJwATI7ar0/KXV2U
   wNMLz6yLbjfv/16XroRoe8g6pwFTSXZ15PPZNVZJ7xn8NrWrgmkvCtxSB
   t7UJ0Oy3EISzDCjfIlAVzJsP9lw4jXHIvBvOawF05jVN2Yiwil97/I4kL
   Z8JprMWjiOrJK7gthl7T8I61UjX1pKzKHNe92Se1D7zvVq1W8SqQu5ROR
   YpTRjehuzIYNKK7PqkTDreF3BQ1eYINYH3AKElhSrtiElda40/9S9LdEM
   A==;
X-CSE-ConnectionGUID: 3kE++MhJS3aQStL5eaHtQQ==
X-CSE-MsgGUID: nFJZlXr+RdWrTRh78G5EZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="100019554"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="100019554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 21:31:21 -0700
X-CSE-ConnectionGUID: YBIskt/GRkmu4UrmWkBLlw==
X-CSE-MsgGUID: tKl/iG5zSIyZlP6FCqHL6A==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jun 2026 21:31:19 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZhvo-00000000U6M-44Yn;
	Wed, 17 Jun 2026 04:31:16 +0000
Date: Wed, 17 Jun 2026 12:30:14 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Egidio <lorenzoegidioms@gmail.com>,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	wim@linux-watchdog.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lorenzo Egidio <lorenzoegidioms@gmail.com>
Subject: Re: [PATCH] Watchdog: fix pretimeout noop governor logging and
 description
Message-ID: <202606171228.xMQDJyrF-lkp@intel.com>
References: <20260616171955.658-1-lorenzoegidioms@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616171955.658-1-lorenzoegidioms@gmail.com>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon]
[also build test WARNING on groeck-staging/hwmon-next groeck-staging/watchdog groeck-staging/watchdog-next linus/master v7.1 next-20260616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Egidio/Watchdog-fix-pretimeout-noop-governor-logging-and-description/20260617-032417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon
patch link:    https://lore.kernel.org/r/20260616171955.658-1-lorenzoegidioms%40gmail.com
patch subject: [PATCH] Watchdog: fix pretimeout noop governor logging and description
config: parisc-randconfig-001-20260617 (https://download.01.org/0day-ci/archive/20260617/202606171228.xMQDJyrF-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260617/202606171228.xMQDJyrF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606171228.xMQDJyrF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/parisc/include/asm/bug.h:97,
                    from include/linux/bug.h:5,
                    from include/linux/instrumented.h:10,
                    from include/linux/atomic/atomic-instrumented.h:17,
                    from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:67,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/parisc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/watchdog/pretimeout_noop.c:6:
   drivers/watchdog/pretimeout_noop.c: In function 'pretimeout_noop':
>> include/linux/kern_levels.h:5:25: warning: format '%d' expects a matching 'int' argument [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:483:25: note: in definition of macro 'printk_index_wrap'
     483 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:534:9: note: in expansion of macro 'printk'
     534 |         printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:9:25: note: in expansion of macro 'KERN_SOH'
       9 | #define KERN_ALERT      KERN_SOH "1"    /* action must be taken immediately */
         |                         ^~~~~~~~
   include/linux/printk.h:534:16: note: in expansion of macro 'KERN_ALERT'
     534 |         printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~
   drivers/watchdog/pretimeout_noop.c:20:9: note: in expansion of macro 'pr_alert'
      20 |         pr_alert("watchdog%d: pretimeout event\n");
         |         ^~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
