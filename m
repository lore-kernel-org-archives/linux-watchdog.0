Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:46355 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3LFTs6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Dec 2013 14:48:58 -0500
Date: Fri, 6 Dec 2013 11:48:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	dianders@chromium.org, kgene.kim@samsung.com, t.figa@samsung.com,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com
Subject: Re: [PATCH V12 3/3] ARM: dts: update watchdog device nodes for
 Exynos5250 and Exynos5420
Message-ID: <20131206194856.GC14464@roeck-us.net>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
 <1386308868-30264-4-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386308868-30264-4-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 06, 2013 at 11:17:48AM +0530, Leela Krishna Amudala wrote:
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
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
