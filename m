Return-path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx
 boards
Date: Tue, 14 Mar 2017 13:58:35 +0100
Message-id: <4386279.iJpUOasmTG@amdc3058>
In-reply-to: <20170311172527.16368-5-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-5-krzk@kernel.org>
 <CGME20170314125837epcas1p481afc11bcf7fc11ef477edda28bccc74@epcas1p4.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>


Hi,

On Saturday, March 11, 2017 07:25:23 PM Krzysztof Kozlowski wrote:
> Watchdog module does not have external dependencies so it can be safely
> enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
> boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Please first fix the driver w.r.t. infinite interrupt in soft mode
issue and only then enable it on more hardware.  IOW this patch
should be placed after patch #7 in the series.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
