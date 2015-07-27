Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51866 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbbG0ONg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 10:13:36 -0400
Message-ID: <55B63C8B.80100@roeck-us.net>
Date: Mon, 27 Jul 2015 07:13:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH 4/5] iTCO_wdt: fixup for the header
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-5-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438004292-16382-5-git-send-email-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/27/2015 06:38 AM, Matt Fleming wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Prevent nested inclusion of the header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

Should be merged into patch 1.

Guenter

> ---
>   include/linux/platform_data/iTCO_wdt.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/platform_data/iTCO_wdt.h b/include/linux/platform_data/iTCO_wdt.h
> index ce53c2b01f6d..0d4f0e87594f 100644
> --- a/include/linux/platform_data/iTCO_wdt.h
> +++ b/include/linux/platform_data/iTCO_wdt.h
> @@ -3,6 +3,7 @@
>    */
>
>   #ifndef _ITCO_WDT_H_
> +#define _ITCO_WDT_H_
>
>   /* Watchdog resources */
>   #define ICH_RES_IO_TCO		0
>

