Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:65254 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaEZXsj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 19:48:39 -0400
Message-ID: <5383D2CA.5020303@roeck-us.net>
Date: Mon, 26 May 2014 16:48:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: Remove drivers for W83697HF and W83697UG
References: <1396722457-8275-1-git-send-email-linux@roeck-us.net> <1396722457-8275-2-git-send-email-linux@roeck-us.net> <20140526212646.GB23827@spo001.leaseweb.com>
In-Reply-To: <20140526212646.GB23827@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2014 02:26 PM, Wim Van Sebroeck wrote:
> Hi Guenter,
>
>> Since both chips are now supported by the w83627hf watchdog driver,
>> the chip specific drivers are no longer needed and can be removed.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v3: rebase to latest upstream kernel
>> v2: resend, no change to v1
>>
>>   drivers/watchdog/Kconfig        |   30 ---
>>   drivers/watchdog/Makefile       |    2 -
>>   drivers/watchdog/w83697hf_wdt.c |  460 ---------------------------------------
>>   drivers/watchdog/w83697ug_wdt.c |  397 ---------------------------------
>>   4 files changed, 889 deletions(-)
>>   delete mode 100644 drivers/watchdog/w83697hf_wdt.c
>>   delete mode 100644 drivers/watchdog/w83697ug_wdt.c
>>
>
> Has been added to linux-watchdog-next.
>
>
Thanks!

Guenter


