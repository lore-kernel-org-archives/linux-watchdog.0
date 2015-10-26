Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34627 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbJZWpY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Oct 2015 18:45:24 -0400
MIME-Version: 1.0
In-Reply-To: <1445587282-29529-4-git-send-email-B48286@freescale.com>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
	<1445587282-29529-4-git-send-email-B48286@freescale.com>
Date: Mon, 26 Oct 2015 17:45:22 -0500
Message-ID: <CADRPPNSdZS0DrxauhA8AmWQrZMLUs06fxLyp4kXonooESVRiXw@mail.gmail.com>
Subject: Re: [PATCH V6 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
From: Li Yang <leoli@freescale.com>
To: Zhiqiang Hou <B48286@freescale.com>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>, corbet@lwn.net,
	Bhupesh Sharma <bhupesh.sharma@freescale.com>,
	mturquette@baylibre.com, wsa@the-dreams.de, sboyd@codeaurora.org,
	wim@iguana.be, Wenbin Song <Wenbin.Song@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>, linux@roeck-us.net
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 23, 2015 at 3:01 AM, Zhiqiang Hou <B48286@freescale.com> wrote:
> From: Mingkai Hu <Mingkai.Hu@freescale.com>
>
> LS1043a is an SoC with 4 ARMv8 A53 cores and most other IP blocks
> similar to LS1021a which complies to Chassis 2.1 spec.
>
> Following levels of DTSI/DTS files have been created for the
> LS1043A SoC family:
>
> - fsl-ls1043a.dtsi:
>   DTS-Include file for FSL LS1043A SoC.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>

Hi Arnd,

Can you also review and merge the LS1043 device tree related patches
in the series(3/6,4/6,6/6)?

Regards,
Leo

> ---
> V6:
>  - No change.
>
> V5:
>  - Move gic, timer and pmu nodes out of SoC node.
>
> V4:
>  - Add soc node with simple-bus compatible.
>  - Add property interrupt-affinity for armv8 pmuv3 node.
>
> V3:
>  - Add device tree node for SATA.
>  - Remove properity enable-method for all cpu node.
>    Remove reserved memory region for spin-table.
>
> V2:
>  - Add secondary core boot method.
>  - Move out the sysclk node from the clockgen node.
>  - Correct the reg size of GICC.
>
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 525 +++++++++++++++++++++++++
>  1 file changed, 525 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
