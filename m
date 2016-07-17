Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43787 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbcGQUQS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:16:18 -0400
Date: Sun, 17 Jul 2016 22:16:15 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-watchdog@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, qipeng.zha@intel.com,
	linux@roeck-us.net, dvhart@infradead.org,
	linux-kernel.vger.kernel.org@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Correct iTCO Watchdog for Apollo Lake
Message-ID: <20160717201615.GA841@spo001.leaseweb.nl>
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com> <1466123612-50633-1-git-send-email-jonathan.yong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466123612-50633-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jonathan,

> These patches fix the iTCO watchdog for Apollo Lake.
> I changed the watchdog memory io to only use 4 bytes rather
> the whole region, I'm not sure if that is the correct way.
> 
> The previous 0x30h offset in intel_pmc_ipc.c was for based
> on the earlier BXT-M platform. Apollo Lake has it at 0x40h.
> 
> Let me know if the patches need changes.
> Please CC me as I am not subscribed, thanks.
> 
> Changes since v1:
> 	* Watchdog NO_REBOOT bit off-by-one corrected.
> 
> Yong, Jonathan (2):
>   watchdog: iTCO-wdt handle 5th variation for Apollo Lake
>   x86: Fix Apollo Lake Watchdog address in PMC driver
> 
>  drivers/platform/x86/intel_pmc_ipc.c | 10 ++++++----
>  drivers/watchdog/iTCO_wdt.c          |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Both patches have been added to linux-watchdog-next.

Kind regards,
Wim.

