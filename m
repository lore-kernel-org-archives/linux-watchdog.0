Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592B31B100;
	Tue, 19 May 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214325; cv=none; b=HXH8rKIxx3Pj7t9MgMErwVC6COyimG/Q1XuQXPztO+C2r+bTjIAMedXiqf7YrJkeJFuLExVueV8F7PJSVs9UEkAThO41oPKNHRC5OyrIjzBjmn6bw2/2fELHYUv8ZxioWeAE4P0hrlh7gRY2FMvr64CsV3I+1xJJGRUgQYvJntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214325; c=relaxed/simple;
	bh=sKezS3aMyFa7kMp1RR5iRKhMM+cLGVkG6KjGoWHS15k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayvXocy9h5Ohf7dMEY+wYVhwMBO3EbVpBmCfVIWr2TSKjKTdoA1Ho6QiwOXjJ/Eh984gjqH75WSDDt5euSzHw+lYInYxpc0OoUZJljShHtQu5FmAPuBfJ/h+kr1jJi3xgz9XlXyVBR0P1Z0XyQDx8DWdoYEPvWyn/G/3HViZfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOFdRqKR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOFdRqKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779214323; x=1810750323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKezS3aMyFa7kMp1RR5iRKhMM+cLGVkG6KjGoWHS15k=;
  b=LOFdRqKROFPmNZNVnXDyPQ8tuvi2uHQLgHgW6cSKPtEL0FCqy90nK0nm
   UNHbMYXFmc1uXv7nQTWchMoGgw6JYL94bTGwk5t3i5d2LtRPhBJJLHkcm
   fo6ohjgxUTtYLzQ5OMm0n3g3mdFnR9fbXATAEWZOioTajWbIKe8TfaxzS
   pX8KvQMtkS9z3lggThnPl6TSirksm1tswkX2BRilaYfbclZV+f/09iNRg
   hByplE5oZaRJMuLn53KWodDiqHw/Fj4R59g+KnGGXvw3aUIoFMzUOYHzO
   kkrZ/3BKSERX2oo2nRDSVeO+2K0xgaPYDi9W6kd5mzJ6pqhIpky/XlujM
   g==;
X-CSE-ConnectionGUID: K8GudIqqTISfZuV7JEi9AA==
X-CSE-MsgGUID: wm/PGplcSheLaF1NtWs1PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90403645"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90403645"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 11:12:03 -0700
X-CSE-ConnectionGUID: 4eauY5zCRcu+2uMVCr3Z+g==
X-CSE-MsgGUID: Kv5eaKL/TdGL6j+sKDb7xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241682443"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 19 May 2026 11:12:01 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPOuk-000000001e7-0iu3;
	Tue, 19 May 2026 18:11:39 +0000
Date: Wed, 20 May 2026 02:08:12 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: select OF and COMPILE_TEST
Message-ID: <202605200244.R8jDfTUk-lkp@intel.com>
References: <20260518210957.10545-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518210957.10545-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon]
[also build test WARNING on groeck-staging/hwmon-next groeck-staging/watchdog groeck-staging/watchdog-next linus/master v7.1-rc4 next-20260518]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/watchdog-ath79_wdt-select-OF-and-COMPILE_TEST/20260519-051137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon
patch link:    https://lore.kernel.org/r/20260518210957.10545-1-rosenp%40gmail.com
patch subject: [PATCH] watchdog: ath79_wdt: select OF and COMPILE_TEST
config: riscv-randconfig-r122-20260519 (https://download.01.org/0day-ci/archive/20260520/202605200244.R8jDfTUk-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605200244.R8jDfTUk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605200244.R8jDfTUk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/ath79_wdt.c:161:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__p @@     got char const * @@
   drivers/watchdog/ath79_wdt.c:161:37: sparse:     expected char const [noderef] __user *__p
   drivers/watchdog/ath79_wdt.c:161:37: sparse:     got char const *
>> drivers/watchdog/ath79_wdt.c:234:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *write )( ... ) @@     got long ( * )( ... ) @@
   drivers/watchdog/ath79_wdt.c:234:27: sparse:     expected long ( *write )( ... )
   drivers/watchdog/ath79_wdt.c:234:27: sparse:     got long ( * )( ... )

vim +161 drivers/watchdog/ath79_wdt.c

f8394f61c66f48 Gabor Juhos         2011-01-04  148  
f8394f61c66f48 Gabor Juhos         2011-01-04  149  static ssize_t ath79_wdt_write(struct file *file, const char *data,
f8394f61c66f48 Gabor Juhos         2011-01-04  150  				size_t len, loff_t *ppos)
f8394f61c66f48 Gabor Juhos         2011-01-04  151  {
f8394f61c66f48 Gabor Juhos         2011-01-04  152  	if (len) {
f8394f61c66f48 Gabor Juhos         2011-01-04  153  		if (!nowayout) {
f8394f61c66f48 Gabor Juhos         2011-01-04  154  			size_t i;
f8394f61c66f48 Gabor Juhos         2011-01-04  155  
f8394f61c66f48 Gabor Juhos         2011-01-04  156  			clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
f8394f61c66f48 Gabor Juhos         2011-01-04  157  
f8394f61c66f48 Gabor Juhos         2011-01-04  158  			for (i = 0; i != len; i++) {
f8394f61c66f48 Gabor Juhos         2011-01-04  159  				char c;
f8394f61c66f48 Gabor Juhos         2011-01-04  160  
f8394f61c66f48 Gabor Juhos         2011-01-04 @161  				if (get_user(c, data + i))
f8394f61c66f48 Gabor Juhos         2011-01-04  162  					return -EFAULT;
f8394f61c66f48 Gabor Juhos         2011-01-04  163  
f8394f61c66f48 Gabor Juhos         2011-01-04  164  				if (c == 'V')
f8394f61c66f48 Gabor Juhos         2011-01-04  165  					set_bit(WDT_FLAGS_EXPECT_CLOSE,
f8394f61c66f48 Gabor Juhos         2011-01-04  166  						&wdt_flags);
f8394f61c66f48 Gabor Juhos         2011-01-04  167  			}
f8394f61c66f48 Gabor Juhos         2011-01-04  168  		}
f8394f61c66f48 Gabor Juhos         2011-01-04  169  
f8394f61c66f48 Gabor Juhos         2011-01-04  170  		ath79_wdt_keepalive();
f8394f61c66f48 Gabor Juhos         2011-01-04  171  	}
f8394f61c66f48 Gabor Juhos         2011-01-04  172  
f8394f61c66f48 Gabor Juhos         2011-01-04  173  	return len;
f8394f61c66f48 Gabor Juhos         2011-01-04  174  }
f8394f61c66f48 Gabor Juhos         2011-01-04  175  
f8394f61c66f48 Gabor Juhos         2011-01-04  176  static const struct watchdog_info ath79_wdt_info = {
f8394f61c66f48 Gabor Juhos         2011-01-04  177  	.options		= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
f8394f61c66f48 Gabor Juhos         2011-01-04  178  				  WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
f8394f61c66f48 Gabor Juhos         2011-01-04  179  	.firmware_version	= 0,
f8394f61c66f48 Gabor Juhos         2011-01-04  180  	.identity		= "ATH79 watchdog",
f8394f61c66f48 Gabor Juhos         2011-01-04  181  };
f8394f61c66f48 Gabor Juhos         2011-01-04  182  
f8394f61c66f48 Gabor Juhos         2011-01-04  183  static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
f8394f61c66f48 Gabor Juhos         2011-01-04  184  			    unsigned long arg)
f8394f61c66f48 Gabor Juhos         2011-01-04  185  {
f8394f61c66f48 Gabor Juhos         2011-01-04  186  	void __user *argp = (void __user *)arg;
f8394f61c66f48 Gabor Juhos         2011-01-04  187  	int __user *p = argp;
f8394f61c66f48 Gabor Juhos         2011-01-04  188  	int err;
f8394f61c66f48 Gabor Juhos         2011-01-04  189  	int t;
f8394f61c66f48 Gabor Juhos         2011-01-04  190  
f8394f61c66f48 Gabor Juhos         2011-01-04  191  	switch (cmd) {
f8394f61c66f48 Gabor Juhos         2011-01-04  192  	case WDIOC_GETSUPPORT:
f8394f61c66f48 Gabor Juhos         2011-01-04  193  		err = copy_to_user(argp, &ath79_wdt_info,
f8394f61c66f48 Gabor Juhos         2011-01-04  194  				   sizeof(ath79_wdt_info)) ? -EFAULT : 0;
f8394f61c66f48 Gabor Juhos         2011-01-04  195  		break;
f8394f61c66f48 Gabor Juhos         2011-01-04  196  
f8394f61c66f48 Gabor Juhos         2011-01-04  197  	case WDIOC_GETSTATUS:
f8394f61c66f48 Gabor Juhos         2011-01-04  198  		err = put_user(0, p);
f8394f61c66f48 Gabor Juhos         2011-01-04  199  		break;
f8394f61c66f48 Gabor Juhos         2011-01-04  200  
f8394f61c66f48 Gabor Juhos         2011-01-04  201  	case WDIOC_GETBOOTSTATUS:
f8394f61c66f48 Gabor Juhos         2011-01-04  202  		err = put_user(boot_status, p);
f8394f61c66f48 Gabor Juhos         2011-01-04  203  		break;
f8394f61c66f48 Gabor Juhos         2011-01-04  204  
f8394f61c66f48 Gabor Juhos         2011-01-04  205  	case WDIOC_KEEPALIVE:
f8394f61c66f48 Gabor Juhos         2011-01-04  206  		ath79_wdt_keepalive();
f8394f61c66f48 Gabor Juhos         2011-01-04  207  		err = 0;
f8394f61c66f48 Gabor Juhos         2011-01-04  208  		break;
f8394f61c66f48 Gabor Juhos         2011-01-04  209  
f8394f61c66f48 Gabor Juhos         2011-01-04  210  	case WDIOC_SETTIMEOUT:
f8394f61c66f48 Gabor Juhos         2011-01-04  211  		err = get_user(t, p);
f8394f61c66f48 Gabor Juhos         2011-01-04  212  		if (err)
f8394f61c66f48 Gabor Juhos         2011-01-04  213  			break;
f8394f61c66f48 Gabor Juhos         2011-01-04  214  
f8394f61c66f48 Gabor Juhos         2011-01-04  215  		err = ath79_wdt_set_timeout(t);
f8394f61c66f48 Gabor Juhos         2011-01-04  216  		if (err)
f8394f61c66f48 Gabor Juhos         2011-01-04  217  			break;
bd490f8222510d Gustavo A. R. Silva 2020-07-07  218  		fallthrough;
f8394f61c66f48 Gabor Juhos         2011-01-04  219  
f8394f61c66f48 Gabor Juhos         2011-01-04  220  	case WDIOC_GETTIMEOUT:
f8394f61c66f48 Gabor Juhos         2011-01-04  221  		err = put_user(timeout, p);
f8394f61c66f48 Gabor Juhos         2011-01-04  222  		break;
f8394f61c66f48 Gabor Juhos         2011-01-04  223  
f8394f61c66f48 Gabor Juhos         2011-01-04  224  	default:
f8394f61c66f48 Gabor Juhos         2011-01-04  225  		err = -ENOTTY;
f8394f61c66f48 Gabor Juhos         2011-01-04  226  		break;
f8394f61c66f48 Gabor Juhos         2011-01-04  227  	}
f8394f61c66f48 Gabor Juhos         2011-01-04  228  
f8394f61c66f48 Gabor Juhos         2011-01-04  229  	return err;
f8394f61c66f48 Gabor Juhos         2011-01-04  230  }
f8394f61c66f48 Gabor Juhos         2011-01-04  231  
f8394f61c66f48 Gabor Juhos         2011-01-04  232  static const struct file_operations ath79_wdt_fops = {
f8394f61c66f48 Gabor Juhos         2011-01-04  233  	.owner		= THIS_MODULE,
f8394f61c66f48 Gabor Juhos         2011-01-04 @234  	.write		= ath79_wdt_write,
f8394f61c66f48 Gabor Juhos         2011-01-04  235  	.unlocked_ioctl	= ath79_wdt_ioctl,
b6dfb2477fb0bf Arnd Bergmann       2019-06-03  236  	.compat_ioctl	= compat_ptr_ioctl,
f8394f61c66f48 Gabor Juhos         2011-01-04  237  	.open		= ath79_wdt_open,
f8394f61c66f48 Gabor Juhos         2011-01-04  238  	.release	= ath79_wdt_release,
f8394f61c66f48 Gabor Juhos         2011-01-04  239  };
f8394f61c66f48 Gabor Juhos         2011-01-04  240  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
