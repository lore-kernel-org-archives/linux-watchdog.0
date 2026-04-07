Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D637754F;
	Tue,  7 Apr 2026 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594058; cv=none; b=OIeUKtEQnNK5Jr7ZemWgnrANeQj9t8yVEhKk94PyPry56oBYdvvBanAEAo5wUYfTTdFwdy7aXBkpG8C3u3zQxhx/rMEpknUilHjYJAPFttcb+/eP92Dc32gfuPO+l7bAwJFgn6sxBgiA2S2H3Ylhu1018/7lSbt0Oly0yXIs4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594058; c=relaxed/simple;
	bh=1ismkApm+QDXDWz0uEATcGq1o2fnIiUpH6tPdIxrtxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+kZZ9vsc2GO0Fuoj0BP/M8qRAJnwAq5YwFRW0DofEMRej5OIOvcbyB398+ZRG+4CsrSgB3uM4IKvvKcs74Fk/0UazWC6gi0xFe5N+vS10fa0WHQ0DfMpcjBhKH+yiL8ZH5FlfI2ny4fN7NqpwtFIwjkgs8geWK+n+Tw2fp1zqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQY01JF1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQY01JF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775594058; x=1807130058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ismkApm+QDXDWz0uEATcGq1o2fnIiUpH6tPdIxrtxg=;
  b=EQY01JF1pM5QeI6BLUGhmVHY04sYFRBZw516M1UIIQnOGWwAUEuXvu17
   qC2LuBsayB/JXsPYZq/yMRtYxGxVpxJULrOX3ZPkTscdU6wwIoZNFuh6k
   XRalRrqHJfPnqQT3lbDRMMr/RiE6Acwv91/KKW2GOkJgURDN5407AYjM3
   0pRqdsUEWqFje9285ceGscfP/aHegWjp7ddL64xNrv2BfCOhjpXY2Ac2h
   zBR+2nVgI7Qo5RzGBsFnzKafQwiahmCLVaumDUqYwQROAcUZEI2vX3SHk
   6SwAlRFleA+P8o32iXQYYjEtBLENqD4AjWeFTDMDoDniYpWySebhXEt8S
   A==;
X-CSE-ConnectionGUID: dSkZpvlYSxqpCB+t4Fr3hg==
X-CSE-MsgGUID: c9tyJvIQQBacXTdyAG2wlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="93956599"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="93956599"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 13:34:17 -0700
X-CSE-ConnectionGUID: uFjpttfdQ4+mC5kKG0UESw==
X-CSE-MsgGUID: IJNDf34cQKuOmr3Hzjgnug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="223498718"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Apr 2026 13:34:14 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wAD7j-0000000011F-1xK3;
	Tue, 07 Apr 2026 20:34:11 +0000
Date: Wed, 8 Apr 2026 04:33:21 +0800
From: kernel test robot <lkp@intel.com>
To: Steve Wahl <steve.wahl@hpe.com>,
	Craig Lamparter <craig.lamparter@hpe.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Russ Anderson <rja@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
	Collins@owl.eag.rdlabs.hpecorp.net
Subject: Re: [PATCH] Refine hpwdt message for UV platform
Message-ID: <202604080401.igdhwsPk-lkp@intel.com>
References: <20260316214530.104344-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316214530.104344-1-steve.wahl@hpe.com>

Hi Steve,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.0-rc7 next-20260406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steve-Wahl/Refine-hpwdt-message-for-UV-platform/20260317-060404
base:   linus/master
patch link:    https://lore.kernel.org/r/20260316214530.104344-1-steve.wahl%40hpe.com
patch subject: [PATCH] Refine hpwdt message for UV platform
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260408/202604080401.igdhwsPk-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604080401.igdhwsPk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604080401.igdhwsPk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/watchdog/hpwdt.c:28:10: fatal error: asm/uv/uv.h: No such file or directory
      28 | #include <asm/uv/uv.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.


vim +28 drivers/watchdog/hpwdt.c

    13	
    14	#include <linux/device.h>
    15	#include <linux/hex.h>
    16	#include <linux/io.h>
    17	#include <linux/kernel.h>
    18	#include <linux/module.h>
    19	#include <linux/moduleparam.h>
    20	#include <linux/pci.h>
    21	#include <linux/pci_ids.h>
    22	#include <linux/types.h>
    23	#include <linux/watchdog.h>
    24	#ifdef CONFIG_HPWDT_NMI_DECODING
    25	#include <asm/nmi.h>
    26	#endif
    27	#include <linux/crash_dump.h>
  > 28	#include <asm/uv/uv.h>
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
