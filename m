Return-Path: <afaerber@suse.de>
Return-path: <afaerber@suse.de>
Subject: Re: [PATCH v2 2/3] watchdog: Add Realtek RTD1295
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
 =?UTF-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>
References: <20170904231602.29787-1-afaerber@suse.de>
 <20170904231602.29787-3-afaerber@suse.de>
 <89c4a85d-fbc7-6fcf-6ff4-63c5580837f8@roeck-us.net>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <155916fd-1689-9a59-3e7c-9e9768a98057@suse.de>
Date: Sun, 10 Sep 2017 18:24:51 +0200
MIME-Version: 1.0
In-Reply-To: <89c4a85d-fbc7-6fcf-6ff4-63c5580837f8@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Am 10.09.2017 um 17:17 schrieb Guenter Roeck:
> On 09/04/2017 04:16 PM, Andreas Färber wrote:
>> Add a watchdog driver for the Realtek RTD1295 SoC.
>>
>> Based on QNAP's arch/arm/mach-rtk119x/driver/rtk_watchdog.c code and
>> mach-rtk119x/driver/dc2vo/fpga/include/iso_reg.h register defines.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks. Will patches 1-2 go through some watchdog tree, or should I
queue them in my Realtek tree now?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
