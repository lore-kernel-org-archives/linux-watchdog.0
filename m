Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35276 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933175AbbG1KNS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 06:13:18 -0400
Received: by wibxm9 with SMTP id xm9so149791068wib.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 03:13:17 -0700 (PDT)
Date: Tue, 28 Jul 2015 11:13:14 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH 3/5] iTCO_wdt: Add support for TCO on Intel Sunrisepoint
Message-ID: <20150728101314.GG2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-4-git-send-email-matt@codeblueprint.co.uk>
 <55B63EBB.7030306@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B63EBB.7030306@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul, at 07:22:51AM, Guenter Roeck wrote:
> On 07/27/2015 06:38 AM, Matt Fleming wrote:
> >From: Matt Fleming <matt.fleming@intel.com>
> >
> >The revision of the watchdog hardware in Sunrisepoint necessitates a new
> >"version" inside the TCO watchdog driver because some of the register
> >layouts have changed.
> >
> >Cc: Wim Van Sebroeck <wim@iguana.be>
> >Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> >---
> >  drivers/watchdog/iTCO_wdt.c | 58 ++++++++++++++++++++++++++-------------------
> >  1 file changed, 34 insertions(+), 24 deletions(-)
> >
> >diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> >index 9a6e70976f64..17dfbc51b85a 100644
> >--- a/drivers/watchdog/iTCO_wdt.c
> >+++ b/drivers/watchdog/iTCO_wdt.c
> >@@ -145,58 +145,65 @@ static inline unsigned int ticks_to_seconds(int ticks)
> >  	return iTCO_wdt_private.iTCO_version == 3 ? ticks : (ticks * 6) / 10;
> >  }
> >
> >+static inline u32 no_reboot_bit(void)
> >+{
> >+	u32 enable_bit;
> >+
> >+	switch (iTCO_wdt_private.iTCO_version) {
> >+	case 3:
> >+		enable_bit = 0x00000010;
> >+		break;
> >+	case 2:
> >+		enable_bit = 0x00000020;
> >+		break;
> >+	default:
> >+		enable_bit = 0x00000002;
> 
> I think it would be better to explicitly list versions 1 and 4 here,
> for clarification. We don't know what Intel will come up with for version 5,
> and by then no one will remember that bit 2 applies for version 1 and 4 only.

Sure, that makes sense. I'll update the patch.

-- 
Matt Fleming, Intel Open Source Technology Center
