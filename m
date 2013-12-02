Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:62699 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab3LBRcq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Dec 2013 12:32:46 -0500
Received: by mail-ve0-f177.google.com with SMTP id db12so8873322veb.8
        for <linux-watchdog@vger.kernel.org>; Mon, 02 Dec 2013 09:32:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1385613243-3559-3-git-send-email-l.krishna@samsung.com>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com>
	<1385613243-3559-3-git-send-email-l.krishna@samsung.com>
Date: Mon, 2 Dec 2013 09:32:45 -0800
Message-ID: <CAD=FV=XvTPbkdopAQVQt-ga2HrwwZ1MSWytMTeDAz=M91icy3g@mail.gmail.com>
Subject: Re: [PATCH V11 2/3] watchdog: s3c2410_wdt: use syscon regmap
 interface to configure pmu register
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, "cpgs ." <cpgs@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Leela Krishna,

On Wed, Nov 27, 2013 at 8:34 PM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> Add device tree support for exynos5250 and 5420 SoCs and use syscon regmap interface
> to configure AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
> to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>  drivers/watchdog/Kconfig                           |    1 +
>  drivers/watchdog/s3c2410_wdt.c                     |  159 ++++++++++++++++++--
>  3 files changed, 171 insertions(+), 10 deletions(-)

Tested on ARM Chromebook in a backport to 3.8.  See
<https://chromium-review.googlesource.com/#/c/177932/3> for this
patch.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
