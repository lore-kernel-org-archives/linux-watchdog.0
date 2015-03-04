Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:61768 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758350AbbCDTYf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 14:24:35 -0500
Message-ID: <1425497072.2090.4.camel@tiscali.nl>
Subject: Re: [PATCH v5 8/9] rtc: st: add new driver for ST's LPC RTC
From: Paul Bolle <pebolle@tiscali.nl>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Date: Wed, 04 Mar 2015 20:24:32 +0100
In-Reply-To: <1425492398-27340-9-git-send-email-lee.jones@linaro.org>
References: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
	 <1425492398-27340-9-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Lee Jones schreef op wo 04-03-2015 om 18:06 [+0000]:
> --- /dev/null
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -0,0 +1,354 @@
> +/*
> + * rtc-st-lpc.c - ST's LPC RTC, powered by the Low Power Timer
> + *
> + * Copyright (C) 2014 STMicroelectronics Limited
> + *
> + * Author: David Paris <david.paris@st.com> for STMicroelectronics
> + *         Lee Jones <lee.jones@linaro.org> for STMicroelectronics
> + *
> + * Based on the original driver written by Stuart Menefy.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPLv2");

This will taint the kernel at module load, won't it? You probably meant
"GPL v2", but only
    MODULE_LICENSE("GPL");

correctly matches the license in the comment at the top of this file. 

(I assume I missed all this when looking at the v4 series.)


Paul Bolle

