Return-Path: <SRS0=8NKm=WY=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BABC3A5A1
	for <linux-watchdog@archiver.kernel.org>; Wed, 28 Aug 2019 12:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E365A217F5
	for <linux-watchdog@archiver.kernel.org>; Wed, 28 Aug 2019 12:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1Mu2 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfH1Mu2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Aug 2019 08:50:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30743B016;
        Wed, 28 Aug 2019 12:50:27 +0000 (UTC)
Date:   Wed, 28 Aug 2019 14:50:34 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 1/2] watchdog: iTCO: Add support for Cannon Lake PCH
 iTCO
Message-ID: <20190828145034.50700666@endymion>
In-Reply-To: <20190809124553.67012-2-mika.westerberg@linux.intel.com>
References: <20190809124553.67012-1-mika.westerberg@linux.intel.com>
        <20190809124553.67012-2-mika.westerberg@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Mika,

On Fri, 9 Aug 2019 15:45:52 +0300, Mika Westerberg wrote:
> In Intel Cannon Lake PCH the NO_REBOOT bit was moved from the private
> register space to be part of the TCO1_CNT register. For this reason
> introduce another version (6) that uses this register to set and clear
> NO_REBOOT bit.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/watchdog/iTCO_wdt.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index c559f706ae7e..505f2c837347 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -215,6 +215,23 @@ static int update_no_reboot_bit_mem(void *priv, bool set)
>  	return 0;
>  }
>  
> +static int update_no_reboot_bit_cnt(void *priv, bool set)
> +{
> +	struct iTCO_wdt_private *p = priv;
> +	u16 val, newval;
> +
> +	val = inw(TCO1_CNT(p));
> +	if (set)
> +		val |= BIT(0);
> +	else
> +		val &= ~BIT(0);

Are you not supposed to include <linux/bits.h> before you use BIT()?

> +	outw(val, TCO1_CNT(p));
> +	newval = inw(TCO1_CNT(p));
> +
> +	/* make sure the update is successful */
> +	return val != newval ? -EIO : 0;
> +}

Other than this minor nitpick, looks good to me.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
