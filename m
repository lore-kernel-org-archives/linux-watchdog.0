Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34296 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbDZP2f (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 Apr 2015 11:28:35 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmOTy-000Y99-GR
	for linux-watchdog@vger.kernel.org; Sun, 26 Apr 2015 15:28:34 +0000
Message-ID: <553D0410.4010802@roeck-us.net>
Date: Sun, 26 Apr 2015 08:28:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
CC: Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@ti.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/3] watchdog: omap: simplify assignment of bootstatus
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de> <1429868913-24049-4-git-send-email-u.kleine-koenig@pengutronix.de> <20150424190317.GV19431@pengutronix.de>
In-Reply-To: <20150424190317.GV19431@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/24/2015 12:03 PM, Uwe Kleine-König wrote:
> On Fri, Apr 24, 2015 at 11:48:33AM +0200, Uwe Kleine-König wrote:
>> Instead of using an over-long expression involving the ?: operator use
>> an if and intead of an else branch rely on the fact that the data
> just noticed ^^ there is an s missing ...
>
> Wim, if you apply this version, can you fix that up?
>

Hi Uwe,

if you don't mind, can you sesend the entire series ?
I don't think patch 1 applies after 1a, and it might make sense
to add some more explanation to patch 2. FWIW, I would say that using
to_omap_wdt_dev() instead of watchdog_get_drvdata() simplifies the code,
or simply that the functions are no longer needed in the driver (ugliness
may be seen as personal opinion).

When you do so, please feel free to add

Reviewed-by: Guenter Roeck <linux@roeck-us.net> to all four patches.

Thanks,
Guenter

