Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <1386308868-30264-3-git-send-email-l.krishna@samsung.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
	<1386308868-30264-3-git-send-email-l.krishna@samsung.com>
Date: Fri, 6 Dec 2013 08:41:06 -0800
Message-ID: <CAD=FV=XL9Vpg9hVZR_rdoP8im1RJ6FMs2eiAaF_4rJxVydbWAw@mail.gmail.com>
Subject: Re: [PATCH V12 2/3] watchdog: s3c2410_wdt: use syscon regmap
 interface to configure pmu register
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>, Guenter Roeck <linux@roeck-us.net>,
	Tomasz Figa <t.figa@samsung.com>, Olof Johansson <olof@lixom.net>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "cpgs ." <cpgs@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-watchdog@vger.kernel.org>

Leela Krishna,

On Thu, Dec 5, 2013 at 9:47 PM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> Add device tree support for exynos5250 and 5420 SoCs and use syscon regmap interface
> to configure AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
> to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>  drivers/watchdog/Kconfig                           |    1 +
>  drivers/watchdog/s3c2410_wdt.c                     |  154 ++++++++++++++++++--
>  3 files changed, 166 insertions(+), 10 deletions(-)

Thank you for incorporating the fixups.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
