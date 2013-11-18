Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:17352 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3KRLFi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Nov 2013 06:05:38 -0500
From: Tomasz Figa <t.figa@samsung.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, devicetree@vger.kernel.org, dianders@chromium.org,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	sachin.kamat@linaro.org, linux@roeck-us.net
Subject: Re: [PATCH V9 0/3] Add watchdog DT nodes and use syscon regmap
 interface to configure pmu registers
Date: Mon, 18 Nov 2013 12:05:24 +0100
Message-id: <1552959.6e3zcBLbjf@amdc1227>
In-reply-to: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On Monday 18 of November 2013 15:19:46 Leela Krishna Amudala wrote:
> This patchset does the following things
> 	- Adds pmusysreg device node to exynos5.dtsi file
> 	- Adds watchdog DT nodes to Exynos5250 and 5420
> 	- Uses syscon regmap interface to configure pmu registers
> 	  to mask/unmask enable/disable of watchdog.

For the whole series:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

