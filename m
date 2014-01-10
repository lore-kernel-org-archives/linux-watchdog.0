Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:51536 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750793AbaAJHim (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Jan 2014 02:38:42 -0500
Date: Fri, 10 Jan 2014 08:38:39 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dianders@chromium.org,
	kgene.kim@samsung.com, t.figa@samsung.com,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, linux@roeck-us.net
Subject: Re: [PATCH V12 2/3] watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu register
Message-ID: <20140110073839.GA12119@spo001.leaseweb.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com> <1386308868-30264-3-git-send-email-l.krishna@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386308868-30264-3-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela

> Add device tree support for exynos5250 and 5420 SoCs and use syscon regmap interface
> to configure AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
> to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

