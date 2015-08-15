Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44564 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbHOXlj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Aug 2015 19:41:39 -0400
Message-ID: <55CFCE2B.9010802@roeck-us.net>
Date: Sat, 15 Aug 2015 16:41:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/8] watchdog: Make set_timeout function optional
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net> <1439010167-13818-5-git-send-email-linux@roeck-us.net> <20150814190535.GV9999@pengutronix.de>
In-Reply-To: <20150814190535.GV9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/14/2015 12:05 PM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Fri, Aug 07, 2015 at 10:02:43PM -0700, Guenter Roeck wrote:
>> For some watchdogs, the hardware timeout is fixed, and the
>> watchdog driver depends on the watchdog core to handle the
>> actual timeout. In this situation, the watchdog driver might
>> only set the 'timeout' variable but do nothing else.
>> This can as well be handled by the infrastructure, so make
>> the set_timeout callback optional. If WDIOF_SETTIMEOUT is
>> configured but the .set_timeout callback is not available,
>> update the timeout variable in the infrastructure code.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>

Thanks!
Guenter


