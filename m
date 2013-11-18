Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:52075 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab3KRJRc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Nov 2013 04:17:32 -0500
MIME-Version: 1.0
In-Reply-To: <1736135.JdedDOBENL@flatron>
References: <1384238088-9862-1-git-send-email-l.krishna@samsung.com>
 <1384238088-9862-2-git-send-email-l.krishna@samsung.com> <1736135.JdedDOBENL@flatron>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Mon, 18 Nov 2013 14:47:11 +0530
Message-ID: <CAL1wa8fxa4h8rxDk4NjovUgJyNOUbfoentPbKsS5-zktKzpa2w@mail.gmail.com>
Subject: Re: [PATCH V8 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
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

On Sat, Nov 16, 2013 at 5:13 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Tuesday 12 of November 2013 12:04:46 Leela Krishna Amudala wrote:
>> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
>> handle PMU register accesses in a centralized way using syscon driver
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/arm/samsung/pmu.txt |   13 +++++++++++++
>>  arch/arm/boot/dts/exynos5250.dtsi                     |    5 +++++
>>  arch/arm/boot/dts/exynos5420.dtsi                     |    5 +++++
>>  3 files changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> new file mode 100644
>> index 0000000..90f975d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
>> @@ -0,0 +1,13 @@
>> +SAMSUNG Exynos SoC series PMU Registers
>> +
>> +Properties:
>> + - name : should be 'syscon';
>> + - compatible : should contain "samsung,<chip name>-pmu", "syscon";
>
> AFAIR there was a discussion about using <chip name> wildcards some
> time ago and if I remember correctly, the conclusion was that the list
> of all supported compatible values should be provided anyway, so there
> is no point in using such wildcards.
>
> This is how I would write this:
>
>  - compatible : should contain two values. First value must be one from
>    following list:
>      - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
>      - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
>    Second value must be always "syscon".
>

Okay, will change it

Best Wishes,
Leela Krishna

> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
