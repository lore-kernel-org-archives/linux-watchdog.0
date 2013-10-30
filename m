Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49905 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab3J3Jwa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 05:52:30 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp18so1184026obc.29
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Oct 2013 02:52:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1383126673-29033-2-git-send-email-l.krishna@samsung.com>
References: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
	<1383126673-29033-2-git-send-email-l.krishna@samsung.com>
Date: Wed, 30 Oct 2013 15:22:29 +0530
Message-ID: <CAK9yfHwHw7esBObW=VATrgweNwqAKu82DGp6miGP0-O7v76c9w@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On 30 October 2013 15:21, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
> This patch adds pmusysreg node to Exynos5 dtsi file to handle PMU
> register accesses in a centralized way using syscon driver
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index e52b038..918e732 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -106,4 +106,9 @@
>                 #size-cells = <0>;
>                 status = "disabled";
>         };
> +
> +       pmu_sys_reg: pmusysreg@1004000 {
> +               compatible = "syscon";
> +               reg = <0x10040000 0x5000>;
> +       };
>  };

Had a look at this in a bit detail and found the following.
The register base address for this block on 5250 and 5420 as per the
TRM is 0x10050000.

Also, the binding document specifies the naming convention. According
to it this node
should like:

sys_reg: sysreg@10050000 {
           compatible = "samsung,exynos5-sysreg", "syscon";
           reg = <0x10050000 0x500>;
};

-- 
With warm regards,
Sachin
