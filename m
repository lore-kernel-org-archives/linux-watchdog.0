Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <1384768189-2839-4-git-send-email-l.krishna@samsung.com>
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
	<1384768189-2839-4-git-send-email-l.krishna@samsung.com>
Date: Mon, 25 Nov 2013 14:46:42 -0800
Message-ID: <CAD=FV=UxMp-JE3WFKJucLFmR5TD8kYP=NVR_mazcdZ6iwjwc3A@mail.gmail.com>
Subject: Re: [PATCH V9 3/3] ARM: dts: update watchdog device nodes for
 Exynos5250 and Exynos5420
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>, Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, "cpgs ." <cpgs@samsung.com>,
	Sachin Kamat <sachin.kamat@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-watchdog@vger.kernel.org>

Leela Krishna,

On Mon, Nov 18, 2013 at 1:49 AM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> In Exynos5 series SoCs, PMU has registers to enable/disable mask/unmask
> watchdog timer which is not the case with s3c series SoCs so, there is a
> need to have different compatible names for watchdog to handle these pmu
> registers access.
>
> Hence this patch removes watchdog node from Exynos5.dtsi common file and
> make it separate by updating existing node in Exynos5250 and adding new node
> to Exynos5420. This patch also makes the watchdog node enabled by default
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |    7 -------
>  arch/arm/boot/dts/exynos5250.dtsi |    6 +++++-
>  arch/arm/boot/dts/exynos5420.dtsi |    9 +++++++++
>  3 files changed, 14 insertions(+), 8 deletions(-)

I've got this locally running in our tree
<https://chromium-review.googlesource.com/#/c/177933/> based on your
patch.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

-Doug
