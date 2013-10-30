Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:33271 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab3J3LWM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 07:22:12 -0400
From: Tomasz Figa <t.figa@samsung.com>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH V4 1/3] ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
Date: Wed, 30 Oct 2013 12:22:09 +0100
Message-id: <1416559.T8R3YI7yDK@amdc1227>
In-reply-to: <CAK9yfHwXMRXM6m9LhOi7tcL+y9iQ3yF5K8DE6PyGyi16RYK3+A@mail.gmail.com>
References: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
 <CAL1wa8dwa3roUwC-KUy2N4fdFEj3tY9V4m_9O+vQWq4T59zxcA@mail.gmail.com>
 <CAK9yfHwXMRXM6m9LhOi7tcL+y9iQ3yF5K8DE6PyGyi16RYK3+A@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 30 of October 2013 15:43:19 Sachin Kamat wrote:
> On 30 October 2013 15:39, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
> > Hi,
> >
> > On Wed, Oct 30, 2013 at 3:22 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> >> Hi Leela,
> >>
> >> On 30 October 2013 15:21, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
> >>> This patch adds pmusysreg node to Exynos5 dtsi file to handle PMU
> >>> register accesses in a centralized way using syscon driver
> >>>
> >>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >>> ---
> >>>  arch/arm/boot/dts/exynos5.dtsi |    5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> >>> index e52b038..918e732 100644
> >>> --- a/arch/arm/boot/dts/exynos5.dtsi
> >>> +++ b/arch/arm/boot/dts/exynos5.dtsi
> >>> @@ -106,4 +106,9 @@
> >>>                 #size-cells = <0>;
> >>>                 status = "disabled";
> >>>         };
> >>> +
> >>> +       pmu_sys_reg: pmusysreg@1004000 {
> >>> +               compatible = "syscon";
> >>> +               reg = <0x10040000 0x5000>;
> >>> +       };
> >>>  };
> >>
> >> Had a look at this in a bit detail and found the following.
> >> The register base address for this block on 5250 and 5420 as per the
> >> TRM is 0x10050000.
> >>
> >> Also, the binding document specifies the naming convention. According
> >> to it this node
> >> should like:
> >>
> >> sys_reg: sysreg@10050000 {
> >>            compatible = "samsung,exynos5-sysreg", "syscon";
> >>            reg = <0x10050000 0x500>;
> >> };
> >>
> >
> > I know, but here my intention is not to regmap system register (0x10050000),
> > but instead PMU register (0x10040000), Hence created this node.
> 
> This clashes with the existing binding for this type of node. Probably
> you will need to
> define it differently?

PMU and System Registers are two completely separate entities. However
a generic syscon binding can be used to represent both, because they are
just collections of registers shared by multiple IPs.

Best regards,
Tomasz

