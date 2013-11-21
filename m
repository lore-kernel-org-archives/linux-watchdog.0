Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:50484 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab3KUFTr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Nov 2013 00:19:47 -0500
MIME-Version: 1.0
In-Reply-To: <1552959.6e3zcBLbjf@amdc1227>
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com> <1552959.6e3zcBLbjf@amdc1227>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Thu, 21 Nov 2013 10:49:25 +0530
Message-ID: <CAL1wa8c98vBNVKz081dBNHXfd8RvGohgFJPwJ0vJihYeMGmr2w@mail.gmail.com>
Subject: Re: [PATCH V9 0/3] Add watchdog DT nodes and use syscon regmap
 interface to configure pmu registers
To: Tomasz Figa <t.figa@samsung.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wim Van Sebroeck,

Can you please review this series and take necessary action.

Best Wishes,
Leela Krishna.

On Mon, Nov 18, 2013 at 4:35 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Leela,
>
> On Monday 18 of November 2013 15:19:46 Leela Krishna Amudala wrote:
>> This patchset does the following things
>>       - Adds pmusysreg device node to exynos5.dtsi file
>>       - Adds watchdog DT nodes to Exynos5250 and 5420
>>       - Uses syscon regmap interface to configure pmu registers
>>         to mask/unmask enable/disable of watchdog.
>
> For the whole series:
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
