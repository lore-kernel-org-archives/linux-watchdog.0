Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35837 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbeGBNQx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 2 Jul 2018 09:16:53 -0400
Subject: Re: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
To: "Tian, Baofeng" <baofeng.tian@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0038B620BAC72941BCBF48AEB892976C02CADE91@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C084@shsmsx102.ccr.corp.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2029ee35-c1c6-86ab-8986-2d79eb5b4d8c@roeck-us.net>
Date: Mon, 2 Jul 2018 06:16:49 -0700
MIME-Version: 1.0
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1C084@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/02/2018 01:18 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
> 
> tristate will allow kernel config it to M and build ko file,
> this will cause build allmodconfig errors as necessary
> symbols have not been exported.
> change it to bool, only allow config ITCO_WDT to yes/no.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>

This works today. I don't see a point changing it, and I am wary doing so.
There are systems where the iTCO watchdog doesn't work (I own one of those),
even though it instantiates, and I am wary of force-loading it.

Besides, you don't explain which "necessary symbols have not been exported".
I do not plan to spend time trying to find out what those symbols are, and
why this would suddenly be a problem.

Guenter

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd..f991e93 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1049,7 +1049,7 @@ config INTEL_MID_WATCHDOG
>          To compile this driver as a module, choose M here.
> 
>   config ITCO_WDT
> -     tristate "Intel TCO Timer/Watchdog"
> +     bool "Intel TCO Timer/Watchdog"
>        depends on (X86 || IA64) && PCI
>        select WATCHDOG_CORE
>        depends on I2C || I2C=n
> -- 
> 2.7.4
> 

