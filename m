Return-path: <krzk@kernel.org>
MIME-Version: 1.0
In-Reply-To: <4386279.iJpUOasmTG@amdc3058>
References: <20170311172527.16368-1-krzk@kernel.org> <CGME20170314125837epcas1p481afc11bcf7fc11ef477edda28bccc74@epcas1p4.samsung.com>
 <20170311172527.16368-5-krzk@kernel.org> <4386279.iJpUOasmTG@amdc3058>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 14 Mar 2017 15:04:28 +0200
Message-ID: <CAJKOXPeCK1cjY78+PfcTprTnyXJ1k9zcUj8nW7onG8y0TWGzzQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx boards
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Mar 14, 2017 at 2:58 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Saturday, March 11, 2017 07:25:23 PM Krzysztof Kozlowski wrote:
>> Watchdog module does not have external dependencies so it can be safely
>> enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
>> boards.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Please first fix the driver w.r.t. infinite interrupt in soft mode
> issue and only then enable it on more hardware.  IOW this patch
> should be placed after patch #7 in the series.

The soft-interrupt mode is not the default one so this should not
cause any issues by default but I got your point. Makes sense. The
pity is the timing. There wasn't much interest in the patchset (no
comments since 24 of Feb) so I merged it yesterday evening. Does it
brake any platform/board?

Best regards,
Krzysztof
