Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35147 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcGEPdn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 11:33:43 -0400
Subject: Re: [RFC 1/6] watchdog: da9063_wdt: don't trigger watchdog too fast
To: Stefan Christ <s.christ@phytec.de>, linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
 <1467724943-13416-2-git-send-email-s.christ@phytec.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <577BD34F.7000804@roeck-us.net>
Date: Tue, 5 Jul 2016 08:33:35 -0700
MIME-Version: 1.0
In-Reply-To: <1467724943-13416-2-git-send-email-s.christ@phytec.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/05/2016 06:22 AM, Stefan Christ wrote:
> Triggering the watchdog faster than T_WDMIN=256ms leads to resets of the
> da9063 chip. The datasheet says that the watchdog must only be triggered
> in the timeframe T_WDMIN to T_WDMAX. The T_WDMAX is configured in the
> driver.
>
> This problem was already mentioned in the patch:
>
>      http://comments.gmane.org/gmane.linux.watchdog/1708
>
> You also could say that this behavior is a feature. When the userspace
> goes wild, triggering the watchdog to fast, the system is reseted. But
> there is currently no information in the watchdog ABI to report a
> minimum wait time between two watchdog heartbeats.
>

There isn't ? What is the problem with min_hw_heartbeat_ms which was
introduced exactly for that purpose ?

Thanks,
Guenter

