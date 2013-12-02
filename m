Return-Path: <olof@lixom.net>
MIME-Version: 1.0
In-Reply-To: <1385613243-3559-2-git-send-email-l.krishna@samsung.com>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com>
	<1385613243-3559-2-git-send-email-l.krishna@samsung.com>
Date: Mon, 2 Dec 2013 10:50:14 -0800
Message-ID: <CAOesGMjbWRwEvuYh2DRvUfKm=fMmLOzpKCOO9p-gNvSXuf5hQg@mail.gmail.com>
Subject: Re: [PATCH V11 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Olof Johansson <olof@lixom.net>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Doug Anderson <dianders@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, cpgs@samsung.com,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On Wed, Nov 27, 2013 at 8:34 PM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> handle PMU register accesses in a centralized way using syscon driver
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   16 ++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>  3 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> new file mode 100644
> index 0000000..307e727
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -0,0 +1,16 @@
> +SAMSUNG Exynos SoC series PMU Registers
> +
> +Properties:
> + - name : should be 'syscon';

It's common to use a non-abbreviated name, such as 'system-controller'
here. Or, given that it's referring to "pmusysreg" then maybe
something like "pmu-system-registers".

> + - compatible : should contain two values. First value must be one from following list:
> +                  - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
> +                  - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
> +               second value must be always "syscon".



-Olof
