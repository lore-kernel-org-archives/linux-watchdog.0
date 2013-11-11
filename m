Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:55277 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab3KKNGC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Nov 2013 08:06:02 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: Re: [PATCH V7 2/3] ARM: dts: update watchdog device nodes for Exynos5250 and Exynos5420
Date: Mon, 11 Nov 2013 05:06:00 -0800 (PST)
Message-ID: <10330347.YPtX4Jly4T@flatron>
In-Reply-To: <1384173897-16106-3-git-send-email-l.krishna@samsung.com>
References: <1384173897-16106-1-git-send-email-l.krishna@samsung.com> <1384173897-16106-3-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On Monday 11 of November 2013 18:14:56 Leela Krishna Amudala wrote:
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
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |    7 -------
>  arch/arm/boot/dts/exynos5250.dtsi |    6 +++++-
>  arch/arm/boot/dts/exynos5420.dtsi |    9 +++++++++
>  3 files changed, 14 insertions(+), 8 deletions(-)

This patch should go as the last in this series, because otherwise it
would change DTS files to use compatible values that are not yet
supported.

The patch itself is fine, so

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

