Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49466 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965442AbcAZQWu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 11:22:50 -0500
Subject: Re: [RFT PATCH] watchdog: gpio: Convert to use infrastructure
 triggered keepalives
To: kbuild test robot <lkp@intel.com>,
	Guenter Roeck <patchwork@patchwork.roeck-us.net>
References: <201601262354.VRXiACmT%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	Doug Anderson <dianders@chromium.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A79D55.8050208@roeck-us.net>
Date: Tue, 26 Jan 2016 08:22:45 -0800
MIME-Version: 1.0
In-Reply-To: <201601262354.VRXiACmT%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/26/2016 07:40 AM, kbuild test robot wrote:
> Hi Guenter,
>
> [auto build test ERROR on v4.5-rc1]
> [also build test ERROR on next-20160125]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Guenter-Roeck/watchdog-gpio-Convert-to-use-infrastructure-triggered-keepalives/20160126-231612
> config: i386-randconfig-x005-01261041 (attached as .config)
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>

Depends on [1].

Guenter

---
[1] https://lkml.org/lkml/2016/1/25/1302

