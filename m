Return-path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] watchdog: s3c2410: Simplify getting driver data
Date: Tue, 14 Mar 2017 14:17:06 +0100
Message-id: <2568764.DQnxL2m83S@amdc3058>
In-reply-to: <20170313190726.2988-3-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
References: <20170313190726.2988-1-krzk@kernel.org>
 <20170313190726.2988-3-krzk@kernel.org>
 <CGME20170314131709epcas5p4e150e0df2a04a3369edf61b2075e2e8f@epcas5p4.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>


Hi,

On Monday, March 13, 2017 09:07:25 PM Krzysztof Kozlowski wrote:
> Simplify the flow in helper function for getting the driver data by
> using of_device_get_match_data() and only one if() branch.
> 
> The code should be equivalent.

While you are at it could you remove s3c2410_get_wdt_drv_data()
helper?  It is used only once during probe and is marked inline
anyway..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
