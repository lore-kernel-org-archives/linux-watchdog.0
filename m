Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35391 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbKWQme (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 11:42:34 -0500
Subject: Re: [PATCH v5 2/8] watchdog: Introduce WDOG_RUNNING flag
To: Alexander Stein <alexander.stein@systec-electronic.com>,
	linux-kernel@vger.kernel.org
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-3-git-send-email-linux@roeck-us.net>
 <8288660.mctbFIZEK3@ws-stein>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565341F6.8040604@roeck-us.net>
Date: Mon, 23 Nov 2015 08:42:30 -0800
MIME-Version: 1.0
In-Reply-To: <8288660.mctbFIZEK3@ws-stein>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/23/2015 08:30 AM, Alexander Stein wrote:
> On Sunday 22 November 2015 19:20:59, Guenter Roeck wrote:
>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
>> index f66859117d1f..3f0963b2c33e 100644
>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>> @@ -212,6 +212,14 @@ bit-operations. The status bits that are defined are:
>>     any watchdog_ops, so that you can be sure that no operations (other then
>>     unref) will get called after unregister, even if userspace still holds a
>>     reference to /dev/watchdog
>> +* WDOG_RUNNING: Set by the watchdog driver if the hardware watchdog is running.
>> +  The bit must be set if the watchdog timer hardware can not be stopped.
>> +  The bit may also be set if the watchdog timer is running aftyer booting,
>                                                                   ^
>                                                                   typo

Thanks, fixed.

Guenter

