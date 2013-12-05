Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:50430 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892Ab3LES10 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Dec 2013 13:27:26 -0500
Received: by mail-qc0-f169.google.com with SMTP id r5so5177075qcx.14
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Dec 2013 10:27:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XvTPbkdopAQVQt-ga2HrwwZ1MSWytMTeDAz=M91icy3g@mail.gmail.com>
References: <1385613243-3559-1-git-send-email-l.krishna@samsung.com>
	<1385613243-3559-3-git-send-email-l.krishna@samsung.com>
	<CAD=FV=XvTPbkdopAQVQt-ga2HrwwZ1MSWytMTeDAz=M91icy3g@mail.gmail.com>
Date: Thu, 5 Dec 2013 10:27:25 -0800
Message-ID: <CAD=FV=UJbNBpdoYuxDoCDUCEEZV3tVZA9DFagY_g0nVQcJJKYg@mail.gmail.com>
Subject: Re: [PATCH V11 2/3] watchdog: s3c2410_wdt: use syscon regmap
 interface to configure pmu register
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Leela Krishna,

On Mon, Dec 2, 2013 at 9:32 AM, Doug Anderson <dianders@chromium.org> wrote:
> Leela Krishna,
>
> On Wed, Nov 27, 2013 at 8:34 PM, Leela Krishna Amudala
> <l.krishna@samsung.com> wrote:
>> Add device tree support for exynos5250 and 5420 SoCs and use syscon regmap interface
>> to configure AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
>> to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
>>  drivers/watchdog/Kconfig                           |    1 +
>>  drivers/watchdog/s3c2410_wdt.c                     |  159 ++++++++++++++++++--
>>  3 files changed, 171 insertions(+), 10 deletions(-)

Based on feedback in another patch series, perhaps you can incorporate
<https://patchwork.kernel.org/patch/3290551/> and spin a v12?

-Doug
