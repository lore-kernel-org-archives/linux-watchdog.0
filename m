Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2on0106.outbound.protection.outlook.com ([207.46.100.106]:16724
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934425AbbIVWnf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Sep 2015 18:43:35 -0400
Message-ID: <1442961804.19102.294.camel@freescale.com>
Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
From: Scott Wood <scottwood@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: Hou Zhiqiang <B48286@freescale.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"Sharma Bhupesh" <bhupesh.sharma@freescale.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>,
	Wenbin Song <Wenbin.Song@freescale.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>,
	Li Leo <LeoLi@freescale.com>,
	"Kushwaha Prabhakar-B32579" <prabhakar@freescale.com>
Date: Tue, 22 Sep 2015 17:43:24 -0500
In-Reply-To: <20150922221504.GA1497@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
	 <1442838158-2964-5-git-send-email-B48286@freescale.com>
	 <20150922012403.GA1535@svinekod>
	 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
	 <20150922221504.GA1497@svinekod>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2015-09-22 at 23:15 +0100, Mark Rutland wrote:
> On Tue, Sep 22, 2015 at 10:50:21AM +0100, Hou Zhiqiang wrote:
> > > > +       ifc:  ifc@1530000{
> > > > +               compatible = "fsl,ifc", "simple-bus";
> > > > +               reg = <0x0 0x1530000 0x0 0x10000>;
> > > > +               interrupts = <0 43 0x4>;
> > > > +       };
> > > 
> > > Why simple-bus?
> > 
> > There are 3 child node located in dtsi file that should be created and 
> > added
> > to platform device list.
> 
> Are they usable even if the kernel knew nothing about the IFC node?

Yes, except for NAND.

>  If not, the IFC driver should probe them, and simple-bus should go.

IFC is not a new binding.  IFC nodes are expected to have simple-bus.

-Scott

