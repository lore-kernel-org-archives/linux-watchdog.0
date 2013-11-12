Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37105 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab3KLF6V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Nov 2013 00:58:21 -0500
MIME-Version: 1.0
In-Reply-To: <10330347.YPtX4Jly4T@flatron>
References: <1384173897-16106-1-git-send-email-l.krishna@samsung.com>
 <1384173897-16106-3-git-send-email-l.krishna@samsung.com> <10330347.YPtX4Jly4T@flatron>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 12 Nov 2013 11:27:59 +0530
Message-ID: <CAL1wa8fe+eRsJ8VsqmCCtsp_ipLK84wNYZ0d0PBJyHUW3zSriA@mail.gmail.com>
Subject: Re: [PATCH V7 2/3] ARM: dts: update watchdog device nodes for
 Exynos5250 and Exynos5420
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomasz,

On Mon, Nov 11, 2013 at 6:36 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Leela,
>
> On Monday 11 of November 2013 18:14:56 Leela Krishna Amudala wrote:
>> In Exynos5 series SoCs, PMU has registers to enable/disable mask/unmask
>> watchdog timer which is not the case with s3c series SoCs so, there is a
>> need to have different compatible names for watchdog to handle these pmu
>> registers access.
>>
>> Hence this patch removes watchdog node from Exynos5.dtsi common file and
>> make it separate by updating existing node in Exynos5250 and adding new node
>> to Exynos5420. This patch also makes the watchdog node enabled by default
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5.dtsi    |    7 -------
>>  arch/arm/boot/dts/exynos5250.dtsi |    6 +++++-
>>  arch/arm/boot/dts/exynos5420.dtsi |    9 +++++++++
>>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> This patch should go as the last in this series, because otherwise it
> would change DTS files to use compatible values that are not yet
> supported.
>

Okay, will make it as last patch in the series

Best Wishes,
Leela Krishna

> The patch itself is fine, so
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>
> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
