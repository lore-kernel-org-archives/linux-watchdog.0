Return-path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] watchdog: s3c2410: Constify local structures
Date: Tue, 14 Mar 2017 14:11:55 +0100
Message-id: <1630264.smGZ3BB1uD@amdc3058>
In-reply-to: <20170313190726.2988-2-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
References: <20170313190726.2988-1-krzk@kernel.org>
 <20170313190726.2988-2-krzk@kernel.org>
 <CGME20170314131158epcas5p3ca1212cc3ce89b0666cafc3aaa87fb78@epcas5p3.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Monday, March 13, 2017 09:07:24 PM Krzysztof Kozlowski wrote:
> Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
> modified so they can be made const to increase code safeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
