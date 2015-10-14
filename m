Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58060 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932202AbbJNMoA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 08:44:00 -0400
Date: Wed, 14 Oct 2015 13:43:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Zhiqiang Hou <B48286@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org, Mingkai.Hu@freescale.com,
	Shaohui.Xie@freescale.com, scottwood@freescale.com,
	bhupesh.sharma@freescale.com, leoli@freescale.com,
	wsa@the-dreams.de, wim@iguana.be, corbet@lwn.net,
	mturquette@baylibre.com, sboyd@codeaurora.org,
	Wenbin.Song@freescale.com
Subject: Re: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Message-ID: <20151014124353.GC2150@leverpostej>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-5-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1444822498-16477-5-git-send-email-B48286@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <0 106 0x4>,
> +			     <0 107 0x4>,
> +			     <0 95 0x4>,
> +			     <0 97 0x4>;
> +	};

You should have interrupt-affinity here. See
Documentation/devicetree/bindings/arm/pmu.txt

Otherwise this looks ok.

Thanks,
Mark.
