Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58467 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbcAJK0U (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jan 2016 05:26:20 -0500
Date: Sun, 10 Jan 2016 18:25:06 +0800
From: kbuild test robot <lkp@intel.com>
To: richard.dorsch@gmail.com
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: Re: [PATCH v2 3/6] Add Advantech iManager HWmon driver
Message-ID: <201601101813.yf6Gealk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452417074-28546-1-git-send-email-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Richard,

[auto build test WARNING on hwmon/hwmon-next]
[also build test WARNING on v4.4-rc8 next-20160108]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/richard-dorsch-gmail-com/Add-Advantech-iManager-EC-driver-set/20160110-171635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/hwmon/imanager-hwmon.c:1047:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
