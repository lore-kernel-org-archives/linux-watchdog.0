Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:42446 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3KJT1d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Nov 2013 14:27:33 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: Re: [PATCH V6 2/3] ARM: dts: add watchdog device nodes for Exynos5250 and Exynos5420
Date: Sun, 10 Nov 2013 20:27:30 +0100
Message-ID: <1741749.lLZhaDvyuy@flatron>
In-Reply-To: <1383825078-24515-3-git-send-email-l.krishna@samsung.com>
References: <1383825078-24515-1-git-send-email-l.krishna@samsung.com> <1383825078-24515-3-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On Thursday 07 of November 2013 17:21:17 Leela Krishna Amudala wrote:
> Adds watchdog device nodes to the DT device list for Exynos5250 and Exynos5420

s/add/update/ since there was already a device tree node in exynos5.dtsi.

Also, patch description should mention all the changes done in the patch
and I see more changes than described by your description. This patch also
makes the watchdog node enabled by default.

Otherwise the patch looks good.

Best regards,
Tomasz

