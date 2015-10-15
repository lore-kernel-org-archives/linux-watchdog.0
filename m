Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2on0148.outbound.protection.outlook.com ([207.46.100.148]:42922
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753384AbbJOD5M (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 23:57:12 -0400
Message-ID: <1444881407.5185.232.camel@freescale.com>
Subject: Re: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
From: Scott Wood <scottwood@freescale.com>
To: Zhiqiang Hou <B48286@freescale.com>
CC: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
	<Mingkai.Hu@freescale.com>, <Shaohui.Xie@freescale.com>,
	<bhupesh.sharma@freescale.com>, <leoli@freescale.com>,
	<wsa@the-dreams.de>, <wim@iguana.be>, <corbet@lwn.net>,
	<mturquette@baylibre.com>, <sboyd@codeaurora.org>,
	<Wenbin.Song@freescale.com>
Date: Wed, 14 Oct 2015 22:56:47 -0500
In-Reply-To: <1444822498-16477-5-git-send-email-B48286@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
	 <1444822498-16477-5-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2015-10-14 at 19:34 +0800, Zhiqiang Hou wrote:
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
> ---
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
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 513 
> +++++++++++++++++++++++++
>  1 file changed, 513 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi

On the ls208x device tree we were asked to put devices under a bus node, such 
as an soc node with a simple-bus compatible.

-Scott

