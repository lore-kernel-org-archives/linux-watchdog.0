Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bon0141.outbound.protection.outlook.com ([157.56.111.141]:40527
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751268AbbJOUqS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Oct 2015 16:46:18 -0400
Message-ID: <1444941949.5185.270.camel@freescale.com>
Subject: Re: [PATCH V4 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
From: Scott Wood <scottwood@freescale.com>
To: Zhiqiang Hou <B48286@freescale.com>
CC: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
	<linux@roeck-us.net>, <wsa@the-dreams.de>, <wim@iguana.be>,
	<corbet@lwn.net>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <Mingkai.Hu@freescale.com>,
	<Shaohui.Xie@freescale.com>, <bhupesh.sharma@freescale.com>,
	<Wenbin.Song@freescale.com>, Li Yang <leoli@freescale.com>,
	Bhupesh Sharma <bhupesh.sharma@freescale.com>
Date: Thu, 15 Oct 2015 15:45:49 -0500
In-Reply-To: <1444911181-21696-4-git-send-email-B48286@freescale.com>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
	 <1444911181-21696-4-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 2015-10-15 at 20:12 +0800, Zhiqiang Hou wrote:
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
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 525 
> +++++++++++++++++++++++++
>  1 file changed, 525 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi 
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> new file mode 100644
> index 0000000..1a5bf79
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -0,0 +1,525 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1043A family SoC.
> + *
> + * Copyright 2014-2015, Freescale Semiconductor
> + *
> + * Mingkai Hu <Mingkai.hu@freescale.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/ {
> +     compatible = "fsl,ls1043a";
> +     interrupt-parent = <&gic>;
> +     #address-cells = <2>;
> +     #size-cells = <2>;
> +
> +     cpus {
> +             #address-cells = <2>;
> +             #size-cells = <0>;
> +
> +             /*
> +              * We expect the enable-method for cpu's to be "psci", but this
> +              * is dependent on the SoC FW, which will fill this in.
> +              *
> +              * Currently supported enable-method is psci v0.2
> +              */
> +             cpu0:  cpu@0{
> +                     device_type = "cpu";
> +                     compatible = "arm,cortex-a53";
> +                     reg = <0x0 0x0>;
> +                     clocks = <&clockgen 1 0>;
> +             };
> +
> +             cpu1:  cpu@1{
> +                     device_type = "cpu";
> +                     compatible = "arm,cortex-a53";
> +                     reg = <0x0 0x1>;
> +                     clocks = <&clockgen 1 0>;
> +             };
> +
> +             cpu2:  cpu@2{
> +                     device_type = "cpu";
> +                     compatible = "arm,cortex-a53";
> +                     reg = <0x0 0x2>;
> +                     clocks = <&clockgen 1 0>;
> +             };
> +
> +             cpu3:  cpu@3{
> +                     device_type = "cpu";
> +                     compatible = "arm,cortex-a53";
> +                     reg = <0x0 0x3>;
> +                     clocks = <&clockgen 1 0>;
> +             };
> +     };
> +
> +      memory@80000000{
> +             device_type = "memory";
> +             reg = <0x0 0x80000000 0 0x80000000>;
> +                   /* DRAM space 1, size: 2GiB DRAM */
> +     };
> +
> +     sysclk: sysclk {
> +             compatible = "fixed-clock";
> +             #clock-cells = <0>;
> +             clock-frequency = <100000000>;
> +             clock-output-names = "sysclk";
> +     };
> +
> +     soc {
> +             compatible = "simple-bus";
> +             #address-cells = <2>;
> +             #size-cells = <2>;
> +             ranges;
> +
> +             clockgen:  clocking@1ee1000{
> +                     compatible = "fsl,ls1043a-clockgen";
> +                     reg = <0x0 0x1ee1000 0x0 0x1000>;
> +                     #clock-cells = <2>;
> +                     clocks = <&sysclk>;
> +             };
> +
> +             timer {
> +                     compatible = "arm,armv8-timer";
> +                     interrupts = <1 13 0x1>, /* Physical Secure PPI */
> +                                  <1 14 0x1>, /* Physical Non-Secure PPI */
> +                                  <1 11 0x1>, /* Virtual PPI */
> +                                  <1 10 0x1>; /* Hypervisor PPI */
> +             };
> +
> +             pmu {
> +                     compatible = "arm,armv8-pmuv3";
> +                     interrupts = <0 106 0x4>,
> +                                  <0 107 0x4>,
> +                                  <0 95 0x4>,
> +                                  <0 97 0x4>;
> +                     interrupt-affinity = <&cpu0>,
> +                                          <&cpu1>,
> +                                          <&cpu2>,
> +                                          <&cpu3>;
> +             };
> +
> +             gic:  interrupt-controller@1400000{
> +                     compatible = "arm,gic-400";
> +                     #interrupt-cells = <3>;
> +                     interrupt-controller;
> +                     reg = <0x0 0x1401000 0 0x1000>, /* GICD */
> +                           <0x0 0x1402000 0 0x2000>, /* GICC */
> +                           <0x0 0x1404000 0 0x2000>, /* GICH */
> +                           <0x0 0x1406000 0 0x2000>; /* GICV */
> +                     interrupts = <1 9 0xf08>;
> +             };

The recently posted ls2080 device tree patch puts pmu, gic, etc. under the 
root node rather than the soc node.  Where should they go?  At least it 
should be consistent...

-Scott

