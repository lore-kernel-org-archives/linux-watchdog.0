Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55921 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757437AbbIVBYL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Sep 2015 21:24:11 -0400
Date: Tue, 22 Sep 2015 02:24:03 +0100
From: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com
To: Zhiqiang Hou <B48286@freescale.com>, marc.zyngier@arm.com
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"Shaohui.Xie@freescale.com" <Shaohui.Xie@freescale.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"Wenbin.Song@freescale.com" <Wenbin.Song@freescale.com>,
	"scottwood@freescale.com" <scottwood@freescale.com>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	"leoli@freescale.com" <leoli@freescale.com>
Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Message-ID: <20150922012403.GA1535@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442838158-2964-5-git-send-email-B48286@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

> +/memreserve/ 0x80000000 0x00010000;

Why is this necessary?

If this is necessary, please add a comment stating what this is for.

> +               cpu@3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53";
> +                       reg = <0x0 0x3>;
> +                       clocks = <&clockgen 1 0>;
> +               };

Missing enable-method properties on all the secondary CPUs.

[...]

> +       gic: interrupt-controller@1400000 {
> +               compatible = "arm,gic-400";
> +               #interrupt-cells = <3>;
> +               interrupt-controller;
> +               reg = <0x0 0x1401000 0 0x1000>, /* GICD */
> +                     <0x0 0x1402000 0 0x1000>, /* GICC */
> +                     <0x0 0x1404000 0 0x2000>, /* GICH */
> +                     <0x0 0x1406000 0 0x2000>; /* GICV */
> +               interrupts = <1 9 0xf08>;
> +       };

These sizes don't look right.

To the best of my knowledge, GICC (and GICV) should be 0x2000 in size, while
GICD and GICH should be 0x1000.

[...]

> +       ifc: ifc@1530000 {
> +               compatible = "fsl,ifc", "simple-bus";
> +               reg = <0x0 0x1530000 0x0 0x10000>;
> +               interrupts = <0 43 0x4>;
> +       };

Why simple-bus?

> +       clockgen: clocking@1ee1000 {
> +               compatible = "fsl,ls1043a-clockgen";
> +               reg = <0x0 0x1ee1000 0x0 0x1000>;
> +               #clock-cells = <2>;
> +               clocks = <&sysclk>;
> +               sysclk: sysclk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <100000000>;
> +                       clock-output-names = "sysclk";
> +               };
> +       };

Why does this fixed clock live under the clockgen? It should live directly
under the root node.

[...]

> +       pcie@3400000 {
> +               compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> +               reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +                      0x40 0x00000000 0x0 0x00002000>; /* configuration space */
> +               reg-names = "regs", "config";
> +               interrupts = <0 118 0x4>, /* controller interrupt */
> +                            <0 117 0x4>; /* PME interrupt */
> +               interrupt-names = "intr", "pme";
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               device_type = "pci";
> +               num-lanes = <4>;
> +               bus-range = <0x0 0xff>;
> +               ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> +                         0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +               msi-parent = <&msi1>;
> +               #interrupt-cells = <1>;
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0000 0 0 1 &gic 0 110 0x4>,
> +                               <0000 0 0 2 &gic 0 111 0x4>,
> +                               <0000 0 0 3 &gic 0 112 0x4>,
> +                               <0000 0 0 4 &gic 0 113 0x4>;
> +       };
> +
> +       pcie@3500000 {
> +               compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> +               reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> +                      0x48 0x00000000 0x0 0x00002000>; /* configuration space */
> +               reg-names = "regs", "config";
> +               interrupts = <0 128 0x4>,
> +                            <0 127 0x4>;
> +               interrupt-names = "intr", "pme";
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               device_type = "pci";
> +               num-lanes = <2>;
> +               bus-range = <0x0 0xff>;
> +               ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
> +                         0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +               msi-parent = <&msi2>;
> +               #interrupt-cells = <1>;
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0000 0 0 1 &gic 0 120  0x4>,
> +                               <0000 0 0 2 &gic 0 121 0x4>,
> +                               <0000 0 0 3 &gic 0 122 0x4>,
> +                               <0000 0 0 4 &gic 0 123 0x4>;
> +       };
> +
> +       pcie@3600000 {
> +               compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> +               reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> +                      0x50 0x00000000 0x0 0x00002000>; /* configuration space */
> +               reg-names = "regs", "config";
> +               interrupts = <0 162 0x4>,
> +                            <0 161 0x4>;
> +               interrupt-names = "intr", "pme";
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               device_type = "pci";
> +               num-lanes = <2>;
> +               bus-range = <0x0 0xff>;
> +               ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
> +                         0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +               msi-parent = <&msi3>;
> +               #interrupt-cells = <1>;
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0000 0 0 1 &gic 0 154 0x4>,
> +                               <0000 0 0 2 &gic 0 155 0x4>,
> +                               <0000 0 0 3 &gic 0 156 0x4>,
> +                               <0000 0 0 4 &gic 0 157 0x4>;
> +       };

You wait ages for a bus, then three show up at once...

> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x80000000 0 0x80000000>;
> +                     /* DRAM space 1 - 2 GB DRAM */

I don't understand the comment. This describes 2GB at 2GB.

Does the bootloader overwrite this?

Thanks,
Mark.
