Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:40811 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab3KYWYJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Nov 2013 17:24:09 -0500
Received: by mail-vc0-f178.google.com with SMTP id lh4so3226364vcb.37
        for <linux-watchdog@vger.kernel.org>; Mon, 25 Nov 2013 14:24:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1384768189-2839-2-git-send-email-l.krishna@samsung.com>
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
	<1384768189-2839-2-git-send-email-l.krishna@samsung.com>
Date: Mon, 25 Nov 2013 14:24:08 -0800
Message-ID: <CAD=FV=UUTZLhxdNWF262crUf2CykkPWj3RRDowusPwEDyjASAg@mail.gmail.com>
Subject: Re: [PATCH V9 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, "cpgs ." <cpgs@samsung.com>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela Krishna,

On Mon, Nov 18, 2013 at 1:49 AM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> handle PMU register accesses in a centralized way using syscon driver
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   16 ++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>  3 files changed, 26 insertions(+)

Looks good to me.  I've tested this applied to our local tree
<https://chromium-review.googlesource.com/#/c/177931/> and it's
working well for me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
