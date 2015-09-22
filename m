Return-Path: <mark.rutland@arm.com>
Date: Tue, 22 Sep 2015 23:15:04 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Hou Zhiqiang <B48286@freescale.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	Sharma Bhupesh <bhupesh.sharma@freescale.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>,
	Wenbin Song <Wenbin.Song@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>, Li Leo <LeoLi@freescale.com>
Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Message-ID: <20150922221504.GA1497@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
List-Archive: <https://lore.kernel.org/linux-clk/>
List-Post: <mailto:linux-clk@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Sep 22, 2015 at 10:50:21AM +0100, Hou Zhiqiang wrote:
> Hi Mark,
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > Sent: 2015年9月22日 9:24
> > To: Hou Zhiqiang-B48286; marc.zyngier@arm.com
> > Cc: linux-arm-kernel@lists.infradead.org; Catalin Marinas; Will Deacon;
> > linux-i2c@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-
> > doc@vger.kernel.org; linux-clk@vger.kernel.org; Xie Shaohui-B21989;
> > corbet@lwn.net; Sharma Bhupesh-B45370; mturquette@baylibre.com; wsa@the-
> > dreams.de; sboyd@codeaurora.org; wim@iguana.be; Song Wenbin-B53747; Wood
> > Scott-B07421; Hu Mingkai-B21284; Li Yang-Leo-R58472
> > Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
> >
> > Hi,
> >
> > > +/memreserve/ 0x80000000 0x00010000;
> >
> > Why is this necessary?
> 
> This memory region is pre-reserved for the spin-table/psci, although didn't add
> Enable method of secondary cores.

Your PSCI implementation isn't in secure memory?

> > > +       ifc: ifc@1530000 {
> > > +               compatible = "fsl,ifc", "simple-bus";
> > > +               reg = <0x0 0x1530000 0x0 0x10000>;
> > > +               interrupts = <0 43 0x4>;
> > > +       };
> >
> > Why simple-bus?
> 
> There are 3 child node located in dtsi file that should be created and added
> to platform device list.

Are they usable even if the kernel knew nothing about the IFC node? If not, the
IFC driver should probe them, and simple-bus should go.

> > > +       memory@80000000 {
> > > +               device_type = "memory";
> > > +               reg = <0x0 0x80000000 0 0x80000000>;
> > > +                     /* DRAM space 1 - 2 GB DRAM */
> >
> > I don't understand the comment. This describes 2GB at 2GB.
> >
> 
> Yes, there is a 2GB space for DRAM from address 2G.
> The DRAM address 0x0 will be remapped to SoC address 2G, this remap is done by hardware.

I just realised my mistake -- I read this as "1 to 2 GB", when this is actually
"DRAM space 1". Sorry for the noise.

Thanks,
Mark.
