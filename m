Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46506 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbbKXHZR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 02:25:17 -0500
Subject: Re: [PATCH v5 5/8] watchdog: Simplify update_worker
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-6-git-send-email-linux@roeck-us.net>
 <20151124071333.GE19888@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565410D8.6070508@roeck-us.net>
Date: Mon, 23 Nov 2015 23:25:12 -0800
MIME-Version: 1.0
In-Reply-To: <20151124071333.GE19888@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 11/23/2015 11:13 PM, Uwe Kleine-König wrote:
> Hello,
>
> On Sun, Nov 22, 2015 at 07:21:02PM -0800, Guenter Roeck wrote:
>> Drop 'cancel' parameter; simply cancel worker unconditionally
>> if not needed.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> This is a good change, but given that watchdog_update_worker is
> introduced in this series it should be squashed accordingly.
>

As I tried to explain, I didn't squash it because, even though
I could not find any trouble with it, I am still not sure if
it may cause trouble or not. As such, I found it better to keep
it separate to make it easier to revert it _if_, as unlikely as
it may be, it should be needed.

Ultimately I'd like to get some input from Wim on this.

Thanks,
Guenter

