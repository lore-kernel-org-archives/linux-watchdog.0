Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44887 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3J3KNT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 06:13:19 -0400
Received: by mail-ob0-f177.google.com with SMTP id vb8so1177219obc.8
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Oct 2013 03:13:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL1wa8dwa3roUwC-KUy2N4fdFEj3tY9V4m_9O+vQWq4T59zxcA@mail.gmail.com>
References: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
	<1383126673-29033-2-git-send-email-l.krishna@samsung.com>
	<CAK9yfHwHw7esBObW=VATrgweNwqAKu82DGp6miGP0-O7v76c9w@mail.gmail.com>
	<CAL1wa8dwa3roUwC-KUy2N4fdFEj3tY9V4m_9O+vQWq4T59zxcA@mail.gmail.com>
Date: Wed, 30 Oct 2013 15:43:19 +0530
Message-ID: <CAK9yfHwXMRXM6m9LhOi7tcL+y9iQ3yF5K8DE6PyGyi16RYK3+A@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 30 October 2013 15:39, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
> Hi,
>
> On Wed, Oct 30, 2013 at 3:22 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Hi Leela,
>>
>> On 30 October 2013 15:21, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
>>> This patch adds pmusysreg node to Exynos5 dtsi file to handle PMU
>>> register accesses in a centralized way using syscon driver
>>>
>>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5.dtsi |    5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>>> index e52b038..918e732 100644
>>> --- a/arch/arm/boot/dts/exynos5.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>>> @@ -106,4 +106,9 @@
>>>                 #size-cells = <0>;
>>>                 status = "disabled";
>>>         };
>>> +
>>> +       pmu_sys_reg: pmusysreg@1004000 {
>>> +               compatible = "syscon";
>>> +               reg = <0x10040000 0x5000>;
>>> +       };
>>>  };
>>
>> Had a look at this in a bit detail and found the following.
>> The register base address for this block on 5250 and 5420 as per the
>> TRM is 0x10050000.
>>
>> Also, the binding document specifies the naming convention. According
>> to it this node
>> should like:
>>
>> sys_reg: sysreg@10050000 {
>>            compatible = "samsung,exynos5-sysreg", "syscon";
>>            reg = <0x10050000 0x500>;
>> };
>>
>
> I know, but here my intention is not to regmap system register (0x10050000),
> but instead PMU register (0x10040000), Hence created this node.

This clashes with the existing binding for this type of node. Probably
you will need to
define it differently?

-- 
With warm regards,
Sachin
