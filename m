Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43708 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbHJRdf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Aug 2015 13:33:35 -0400
Message-ID: <55C8E06A.6070808@roeck-us.net>
Date: Mon, 10 Aug 2015 10:33:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 3/5] watchdog: mpc8xxx: make use of of_device_get_match_data
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de> <1438942067-1654-4-git-send-email-u.kleine-koenig@pengutronix.de> <20150810072534.GQ9999@pengutronix.de>
In-Reply-To: <20150810072534.GQ9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/10/2015 12:25 AM, Uwe Kleine-K=F6nig wrote:
> On Fri, Aug 07, 2015 at 12:07:45PM +0200, Uwe Kleine-K=F6nig wrote:
>> This function is new in v4.2-rc1 and makes a forward declaration of =
the
>> match table superfluous which can so be removed.
>>
>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> This patch is broken, it is supposed to do less, I'll look into this
> later.
>
>
Ok, thanks for the heads-up.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
