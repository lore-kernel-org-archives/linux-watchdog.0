Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FB3101B2;
	Wed, 17 Jun 2026 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781670928; cv=none; b=qSwBEZLz2V0KUMCMSiOKTH78RO17A/iEJDP8CykcL3FOwPIe4LmBky/uR8gRYQaAfTWldOOv57pRMz+4og28+fkd4fhX3/I+nNmO3w2wftf5s0IHnKxaWmHGooOcqOvoiyiwimsSh6XjD4N6E2TB0V2Xpp7XU3VpNbGA+7NlRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781670928; c=relaxed/simple;
	bh=BC7H3SUJGBV4Ff+tObZqFQ+llNMOtjcsxJP1wBk9UKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcGYNllxx7s0ViuETmbGkGrQGz85j7C9fRj1G13E02uiX5rMxNpYR7xtzlY7oon5gTtd/vRIbGBufyPyjQ1E7qOCx1Ysq4qQycK2q8PDetKrCY/MCaEYBAHtbzX5vdJlKEoUz6uqjswh0OYt/KLzb2kJyRQ9KKIwbk6TyvQATl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJk+8kW6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJk+8kW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781670927; x=1813206927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BC7H3SUJGBV4Ff+tObZqFQ+llNMOtjcsxJP1wBk9UKs=;
  b=cJk+8kW6L7/gOya/FVju8lPyAaoNRcLn4ZYWzGO1T5a+xGdaNuOktO4A
   ZJmgnKl2M4Ep/hkjOcFoWxBFpsOkfhP5XLg9C41Kg0beGOnanA3mdtcJt
   a/WNZB56DAkC1bfDpzoaQnEILm+hgezUjYAAoTq0fYuQQuEBWRMSUm56I
   Vl0LSQ2QTpTd1fiqwv4rnE/1IwJWoKKQiMpLoBYkcy7BFkgoMeCL7Wj/M
   Zc4plafqsfvm7xmqjjgEnvvYpg3dve6QY+oadXe1jcsKAu5Bj2mGkOj3H
   4+xAxtWpgkErU5p9PrUtW188INP4ssdzlY29AAOny06uK9aUJ9JnGNZio
   w==;
X-CSE-ConnectionGUID: VOxJZvR9QUuOM8ePTmAr+Q==
X-CSE-MsgGUID: F0noS1e6QpqycmFac0wjTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="107919618"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="107919618"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 21:35:26 -0700
X-CSE-ConnectionGUID: aFC8YRqkS8mk209pM/l/rw==
X-CSE-MsgGUID: ZOJFCGI0R2qjaZ2in9EXyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="286069040"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Jun 2026 21:35:24 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZhzl-00000000U6g-1kfL;
	Wed, 17 Jun 2026 04:35:21 +0000
Date: Wed, 17 Jun 2026 12:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Egidio <lorenzoegidioms@gmail.com>,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	wim@linux-watchdog.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lorenzo Egidio <lorenzoegidioms@gmail.com>
Subject: Re: [PATCH] Watchdog: fix pretimeout noop governor logging and
 description
Message-ID: <202606171208.XDs3KbGh-lkp@intel.com>
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
config: i386-randconfig-141-20260617 (https://download.01.org/0day-ci/archive/20260617/202606171208.XDs3KbGh-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260617/202606171208.XDs3KbGh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606171208.XDs3KbGh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/pretimeout_noop.c:20:21: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
      20 |         pr_alert("watchdog%d: pretimeout event\n");
         |                           ~^
   include/linux/printk.h:534:27: note: expanded from macro 'pr_alert'
     534 |         printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |                                  ^~~
   include/linux/printk.h:401:21: note: expanded from macro 'pr_fmt'
     401 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/printk.h:511:53: note: expanded from macro 'printk'
     511 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ^~~
   include/linux/printk.h:483:11: note: expanded from macro 'printk_index_wrap'
     483 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   1 warning generated.


vim +20 drivers/watchdog/pretimeout_noop.c

    11	
    12	/**
    13	 * pretimeout_noop - No operation on watchdog pretimeout event
    14	 * @wdd: watchdog_device
    15	 *
    16	 * This function prints a message about pretimeout to kernel log.
    17	 */
    18	static void pretimeout_noop(struct watchdog_device *wdd)
    19	{
  > 20		pr_alert("watchdog%d: pretimeout event\n");
    21	}
    22	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
