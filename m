Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2on0119.outbound.protection.outlook.com ([207.46.100.119]:29248
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750716AbbIWEQN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Sep 2015 00:16:13 -0400
From: Li Leo <LeoLi@freescale.com>
To: Hou Zhiqiang <B48286@freescale.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
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
	Scott Wood <scottwood@freescale.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Wed, 23 Sep 2015 04:16:10 +0000
Message-ID: <DM2PR0301MB0734302E89290593BE7D9565BA440@DM2PR0301MB0734.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
 <CY1PR0301MB07805FA01ACAF84648C806138B440@CY1PR0301MB0780.namprd03.prod.outlook.com>
In-Reply-To: <CY1PR0301MB07805FA01ACAF84648C806138B440@CY1PR0301MB0780.namprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > > >
> > > > Hi,
> > > >
> > > > > +/memreserve/ 0x80000000 0x00010000;
> > > >
> > > > Why is this necessary?
> > >
> > > This memory region is pre-reserved for the spin-table/psci, although
> > > didn't add Enable method of secondary cores.
> >
> > Can this be reserved by bootloader?
> 
> Yes, the memory for psci was reserved by u-boot code. But due to spin-table
> need the release address, is it better adding the /memreserve/ in dts file?
> Or add it by bootloader and fix the release address accordingly?

Both the reserved memory region and cpu-release-addr should be updated by bootloader.

Regards,
Leo
