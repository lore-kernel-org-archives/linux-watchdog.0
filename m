Return-Path: <t.figa@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Message-id: <53BBFF22.10904@samsung.com>
Date: Tue, 08 Jul 2014 16:24:34 +0200
From: Tomasz Figa <t.figa@samsung.com>
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Wim Van Sebroeck <wim@iguana.be>, linux-samsung-soc@vger.kernel.org,
 Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH 2/3] clk: samsung: register restart notifiers for
 s3c2412 and s3c2443
References: <1531376.ijR0PPyvmJ@diego> <1436436.XH2jFxzQOf@diego>
In-reply-to: <1436436.XH2jFxzQOf@diego>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Heiko,

On 06.07.2014 20:43, Heiko Stübner wrote:
> S3C2412, S3C2443 and their derivatives contain a special software-reset
> register in their system-controller.
> 
> Therefore register a restart-notifier for those.

I wonder if we really need to differentiate between these SoCs instead
of just using the watchdog reset for all of them. If there is no reason
to prefer software reset, then some code could be removed and things
would be more unified.

Best regards,
Tomasz
