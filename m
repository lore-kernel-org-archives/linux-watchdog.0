From: "Langer, Thomas" <thomas.langer@intel.com>
To: Mark Brown <broonie@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>
CC: "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com"
        <martin.blumenstingl@googlemail.com>,
        "john@phrozen.org" <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Mehrtens, Hauke" <hauke.mehrtens@intel.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
Date: Wed, 9 Aug 2017 14:02:16 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
 <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
In-Reply-To: <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>



> -----Original Message-----
> From: linux-spi-owner@vger.kernel.org [mailto:linux-spi-
> owner@vger.kernel.org] On Behalf Of Mark Brown
> Sent: Wednesday, August 9, 2017 1:44 PM
> To: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: ralf@linux-mips.org; linux-mips@linux-mips.org; linux-
> mtd@lists.infradead.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; martin.blumenstingl@googlemail.com;
> john@phrozen.org; linux-spi@vger.kernel.org; Mehrtens, Hauke
> <hauke.mehrtens@intel.com>; robh@kernel.org; andy.shevchenko@gmail.com;
> p.zabel@pengutronix.de; kishon@ti.com; mark.rutland@arm.com
> Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
> 
> On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:
> 
> > Do not check which flash type the SoC was booted from before
> > using this driver. Assume that the device tree is correct and use this
> > driver when it was added to device tree. This also removes a build
> > dependency to the SoC code.
> 
> Why?  Is this assumption reliably true?

Yes. We only have one type of flash interface in the device tree, as they 
are connected to the shared EBU (External Bus Unit).
