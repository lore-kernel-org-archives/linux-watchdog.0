Return-path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 8/8] ARM: dts: s5pv210: Fix infinite interrupt in soft
 mode
Date: Tue, 14 Mar 2017 14:07:35 +0100
Message-id: <18872645.gYpaTZ7CIU@amdc3058>
In-reply-to: <20170311172527.16368-9-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-9-krzk@kernel.org>
 <CGME20170314130737epcas5p2acd94980f020d95f52ac53e3ca1eb258@epcas5p2.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Saturday, March 11, 2017 07:25:27 PM Krzysztof Kozlowski wrote:
> In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> of an interrupt.  The interrupt has to be cleared, because otherwise
> system enters infinite interrupt handling loop.
> 
> Use a samsung,s3c6410-wdt compatible to select appropriate quirk for
> clearing the watchdog interrupt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
