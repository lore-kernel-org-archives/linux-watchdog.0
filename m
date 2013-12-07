Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54296 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab3LGHOg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Dec 2013 02:14:36 -0500
Message-ID: <52A2CADB.2070700@roeck-us.net>
Date: Fri, 06 Dec 2013 23:14:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexander Shiyan <shc_work@mail.ru>
CC: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3] watchdog: GPIO-controlled watchdog
References: <1385798072-3886-1-git-send-email-shc_work@mail.ru> <20131207105258.b9597225842794cadd15e08f@mail.ru>
In-Reply-To: <20131207105258.b9597225842794cadd15e08f@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/06/2013 10:52 PM, Alexander Shiyan wrote:
> On Sat, 30 Nov 2013 11:54:32 +0400
> Alexander Shiyan <shc_work@mail.ru> wrote:
>
>> This patch adds a watchdog driver for devices controlled through GPIO,
>> (Analog Devices ADM706, Maxim MAX823, National NE555 etc).
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>> ---
>>   .../devicetree/bindings/watchdog/gpio-wdt.txt      |  23 ++
>>   drivers/watchdog/Kconfig                           |   8 +
>>   drivers/watchdog/Makefile                          |   1 +
>>   drivers/watchdog/gpio_wdt.c                        | 254 +++++++++++++++++++++
>>   4 files changed, 286 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>>   create mode 100644 drivers/watchdog/gpio_wdt.c
> ...
>
> Ping.
>

Wim typically only finds the time to look at pending patches a couple of weeks before
the next commit window opens. I'll send him a reminder with all patches I am aware of
in a week or so. I have this one in my list.

Guenter

