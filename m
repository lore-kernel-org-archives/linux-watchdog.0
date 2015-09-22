Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bbn0105.outbound.protection.outlook.com ([157.56.111.105]:3840
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752960AbbIVBpF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Sep 2015 21:45:05 -0400
Message-ID: <1442885429.19102.210.camel@freescale.com>
Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
From: Scott Wood <scottwood@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>, <marc.zyngier@arm.com>
CC: Zhiqiang Hou <B48286@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
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
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	"leoli@freescale.com" <leoli@freescale.com>
Date: Mon, 21 Sep 2015 20:30:29 -0500
In-Reply-To: <20150922012403.GA1535@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
	 <1442838158-2964-5-git-send-email-B48286@freescale.com>
	 <20150922012403.GA1535@svinekod>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2015-09-22 at 02:24 +0100, Mark Rutland wrote:
> > +       clockgen:  clocking@1ee1000{
> > +               compatible = "fsl,ls1043a-clockgen";
> > +               reg = <0x0 0x1ee1000 0x0 0x1000>;
> > +               #clock-cells = <2>;
> > +               clocks = <&sysclk>;
> > +               sysclk: sysclk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <100000000>;
> > +                       clock-output-names = "sysclk";
> > +               };
> > +       };
> 
> Why does this fixed clock live under the clockgen? It should live directly
> under the root node.

I think this is copy-and-paste from some legacy PPC stuff.  There's no reason 
anymore to put sysclk under clockgen.

-Scott


