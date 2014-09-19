Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34968 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaISEMz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 00:12:55 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XUpZ0-001Q4p-Lq
	for linux-watchdog@vger.kernel.org; Fri, 19 Sep 2014 04:12:54 +0000
Message-ID: <541BAD2C.8080902@roeck-us.net>
Date: Thu, 18 Sep 2014 21:12:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Rostislav Lisovy <lisovy@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, sojkam1@fel.cvut.cz,
	michal.vokac@comap.cz, Rostislav Lisovy <lisovy@merica.cz>
Subject: Re: [PATCH v2] watchdog: omap_wdt: Add 'early_disable' module parameter
References: <1410877228-20925-1-git-send-email-lisovy@merica.cz>	 <20140916154921.GA14725@roeck-us.net> <1410967369.5542.2.camel@lp-lvrv.comap.cz>
In-Reply-To: <1410967369.5542.2.camel@lp-lvrv.comap.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/17/2014 08:22 AM, Rostislav Lisovy wrote:
> Hello Guenter;
> Thanks for the review.
>
> On Út, 2014-09-16 at 08:49 -0700, Guenter Roeck wrote:
>> How do you know that the watchdog was already running ?
>> Seems to me you are just making an assumption that it is running
>> without really knowing for sure.
>
> You are definitely right, however the OMAP Watchdog seems to be such a
> sophisticated piece of hardware that there is no possible way how to
> determine if it is running or not (sampling timer counter twice and
> comparing both values is they differ is stupid).
>
How about reading the OMAP_WATCHDOG_SPR register ?

Either case, you can not issue a message about the watchdog being
stopped or started if you don't know if it was actually stopped
or started. Also, if you don't really know if the watchdog was
stopped or started, all you can do is to either stop or start it,
without judgment about its previous condition.

Guenter

