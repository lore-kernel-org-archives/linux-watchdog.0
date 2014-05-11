Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from yotta.elopez.com.ar ([31.220.24.173]:51958 "EHLO
	yotta.elopez.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933905AbaEKTrJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 11 May 2014 15:47:09 -0400
Message-ID: <536FD3B3.3030100@elopez.com.ar>
Date: Sun, 11 May 2014 16:46:59 -0300
From: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	wim@iguana.be, carlo.caione@gmail.com
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar> <533EF39D.6090907@roeck-us.net>
In-Reply-To: <533EF39D.6090907@roeck-us.net>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

El 04/04/14 15:02, Guenter Roeck escribi=C3=B3:
> On 04/04/2014 10:24 AM, Emilio L=C3=B3pez wrote:
>> When compiling sunxi_defconfig while using C=3D2, the following erro=
r
>> causes the compilation to fail:
>>
>>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is n=
ot
>> a valid number
>>
>> Fix it by using hex notation instead of the non-standard binary one
>>
>> Signed-off-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Wim, Maxime, any comments on this?

Cheers,

Emilio
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
