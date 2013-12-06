Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <1386308868-30264-2-git-send-email-l.krishna@samsung.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
	<1386308868-30264-2-git-send-email-l.krishna@samsung.com>
Date: Fri, 6 Dec 2013 08:38:50 -0800
Message-ID: <CAD=FV=VfxvOLAi5T+cUkQOxQfW08tE_JZtq5-9pQAo4h4z3Pxw@mail.gmail.com>
Subject: Re: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>, Olof Johansson <olof@lixom.net>,
	Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "cpgs ." <cpgs@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-watchdog@vger.kernel.org>

Leela Krishna,

On Thu, Dec 5, 2013 at 9:47 PM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> handle PMU register accesses in a centralized way using syscon driver
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   15 +++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>  3 files changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> new file mode 100644
> index 0000000..f1f1552
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -0,0 +1,15 @@
> +SAMSUNG Exynos SoC series PMU Registers
> +
> +Properties:
> + - compatible : should contain two values. First value must be one from following list:
> +                  - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
> +                  - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
> +               second value must be always "syscon".
> +
> + - reg : offset and length of the register set.
> +
> +Example :
> +pmu_system_controller: system-controller@10040000 {
> +       compatible = "samsung,exynos5250-pmu", "syscon";
> +       reg = <0x10040000 0x5000>;
> +};

This looks right to me based on previous discussion.  Hopefully Olof
and/or Tomasz can indicate that they're happy with it now.

-Doug
