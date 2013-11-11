Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:64278 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab3KKNAn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Nov 2013 08:00:43 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: Re: [PATCH V7 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420 dtsi files
Date: Mon, 11 Nov 2013 14:00:40 +0100
Message-ID: <10730719.0dfncB4RfV@flatron>
In-Reply-To: <1384173897-16106-2-git-send-email-l.krishna@samsung.com>
References: <1384173897-16106-1-git-send-email-l.krishna@samsung.com> <1384173897-16106-2-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On Monday 11 of November 2013 18:14:55 Leela Krishna Amudala wrote:
> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> handle PMU register accesses in a centralized way using syscon driver
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   13 +++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

