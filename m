Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41107 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab3A1WGN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Jan 2013 17:06:13 -0500
Message-ID: <5106F64B.6040801@hauke-m.de>
Date: Mon, 28 Jan 2013 23:06:03 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, zajec5@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs
 with PMU
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de> <51016C4D.40707@hauke-m.de> <20130128213544.GB3338@spo001.leaseweb.com>
In-Reply-To: <20130128213544.GB3338@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/28/2013 10:35 PM, Wim Van Sebroeck wrote:
> Hi Hauke,
> 
>> what is the status of these patches?
> 
> First reading/checking (v4+v5) seems OK.
> 1 small remark allready: the settimeout functions seem to check the min and max timeout values.
> Can't you use the min and max values of the watchdog structure for this?
> 
> Kind regards,
> Wim.
> 
Hi Wim,

The max_timer_ms attribute in struct bcm47xx_wdt contains the maximum
value the hardware is capable of, the watchdog driver uses a softtimer
if this value is too low and in that case it is no problem if a
userspace application sets the timeout to some value higher than
max_timer_ms.

If I would use max_timeout from struct watchdog_device I would have to
change that values when softtimer is selected.

The best solution would be if the softtimer choice and implementation
would go to watchdog_dev.c as some more watchdog driver do something
similar.

Hauke
