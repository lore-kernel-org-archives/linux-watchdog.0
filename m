Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49758 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbbKXQpL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 11:45:11 -0500
Subject: Re: [PATCH v5 1/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-2-git-send-email-linux@roeck-us.net>
 <20151124071628.GF19888@pengutronix.de> <56547C31.3070901@roeck-us.net>
 <20151124161147.GH19888@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56549411.7000209@roeck-us.net>
Date: Tue, 24 Nov 2015 08:45:05 -0800
MIME-Version: 1.0
In-Reply-To: <20151124161147.GH19888@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 11/24/2015 08:11 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Tue, Nov 24, 2015 at 07:03:13AM -0800, Guenter Roeck wrote:
>> thanks a lot for the Ack. I have v6 in the works, which changes recording
>> of last_keepalive when the watchdog is started. Does your Ack include that
>> change, or do you prefer to have another look ?
>
> this change is to sample jiffies before .start is called as I suggested,
> right? For that change keeping my ack is ok of course.
>

Correct. This is how the code now looks like.

         started_at = jiffies;
         if (watchdog_hw_running(wdd) && wdd->ops->ping)
                 err = wdd->ops->ping(wdd);
         else
                 err = wdd->ops->start(wdd);
         if (err == 0) {
                 set_bit(WDOG_ACTIVE, &wdd->status);
                 wdd->last_keepalive = started_at;
                 watchdog_update_worker(wdd);
         }

Thanks,
Guenter

