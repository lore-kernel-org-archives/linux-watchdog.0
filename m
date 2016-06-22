Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41867 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcFVE4X (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2016 00:56:23 -0400
Message-ID: <576A19BC.4000502@intel.com>
Date: Wed, 22 Jun 2016 12:53:16 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
CC: qipeng.zha@intel.com, linux@roeck-us.net, dvhart@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Correct iTCO Watchdog for Apollo Lake
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com> <1466123817-50679-1-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1466123817-50679-1-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/17/2016 08:36, Yong, Jonathan wrote:
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
> * Resent, typo in linux-kernel email address
>
> Changes since v1:
> 	* Watchdog NO_REBOOT bit off-by-one corrected.
>
> Yong, Jonathan (2):
>    watchdog: iTCO-wdt handle 5th variation for Apollo Lake
>    x86: Fix Apollo Lake Watchdog address in PMC driver
>
>   drivers/platform/x86/intel_pmc_ipc.c | 10 ++++++----
>   drivers/watchdog/iTCO_wdt.c          |  2 ++
>   2 files changed, 8 insertions(+), 4 deletions(-)
>

Ping.

